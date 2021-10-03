use crate::hydra::client::HydraClient;
use crate::hydra::client::JobsetOverview;
use crate::ops::{ok, OpError, OpResult};
use std::io;
use std::io::Write;
use std::option::Option;
use std::thread;
use std::time::SystemTime;
use std::time::{Duration, UNIX_EPOCH};

fn evaluation_started_since(jobset: &JobsetOverview) -> Option<Duration> {
    let starttime = jobset.starttime?;
    SystemTime::now()
        .duration_since(UNIX_EPOCH + Duration::from_secs(starttime))
        .ok()
}

fn is_evaluation_finished_after(jobset: &JobsetOverview, start: SystemTime) -> bool {
    match jobset.lastcheckedtime {
        None => false,
        Some(t) => (UNIX_EPOCH + Duration::from_secs(t)) > start,
    }
}

fn is_jobset_built(client: &dyn HydraClient, jobset: &JobsetOverview) -> Result<bool, OpError> {
    if jobset.haserrormsg.unwrap_or(false) {
        println!();
        Err(OpError::Error(format!(
            "evaluation of jobset {} failed; for details: {}/jobset/{}/{}",
            jobset.name,
            client.host(),
            jobset.project,
            jobset.name
        )))
    } else if jobset.nrfailed != 0 {
        println!();
        Err(OpError::Error(format!(
            "Jobset {} has {} failed jobs; for details: {}/jobset/{}/{}",
            jobset.name,
            jobset.nrfailed.to_string(),
            client.host(),
            jobset.project,
            jobset.name
        )))
    } else if jobset.nrsucceeded == jobset.nrtotal {
        println!(
            "\nall jobs of jobset {} have been built",
            jobset.name.to_string()
        );
        Ok(true)
    } else {
        Ok(false)
    }
}

fn jobset_find(
    client: &dyn HydraClient,
    project_name: &str,
    jobset_name: &str,
) -> Result<JobsetOverview, OpError> {
    let jobsets = client.jobset_overview(project_name)?;
    jobsets
        .into_iter()
        .find(|j| j.name == jobset_name)
        .ok_or_else(|| {
            OpError::Error(format!(
                "Project {} doesn't have a jobset {}",
                project_name, jobset_name
            ))
        })
}

// To know if a jobset has been successfully built, five steps are required:
// 0. wait for the jobset creation               : WaitingForJobset
// 1. ensure a evaluation is not running         : WaitingForPreviousEval
// 2. wait for a new evaluation to start         : WaitingForNewEval
// 3. wait for this evaluation to be terminated  : Evaluation
// 4. wait for all scheduled builds to terminate : Building
//
// If a build or the evaluation fails, it immediately returns an error.
//
// There are several improvements, such as
// - use the checkinterval to know when the next evaluation will start
// - use the push Hydra API to trigger an evaluation (but this needs credentials)
pub fn run(
    client: &dyn HydraClient,
    project_name: &str,
    jobset_name: &str,
    timeout: Option<Duration>,
) -> OpResult {
    #[derive(PartialEq)]
    enum State {
        WaitingForJobset,
        WaitingForPreviousEval,
        WaitingForNewEval,
        Evaluating,
        Building,
    }
    let sleep = Duration::from_secs(2);
    let mut state = State::WaitingForJobset;
    let mut start = SystemTime::now();
    let timeout_start = start;
    let mut nrscheduled = 0;

    println!(
        "waiting for jobset {}/{} ({}/jobset/{}/{})",
        project_name,
        jobset_name,
        client.host(),
        project_name,
        jobset_name
    );
    loop {
        match timeout {
            Some(t) if SystemTime::now().duration_since(timeout_start).unwrap() > t => {
                return Err(OpError::TimeoutError)
            }
            _ => {}
        }

        match jobset_find(client, project_name, jobset_name) {
            Err(_) => {
                // The jobset should not disappear if it has already been seen!
                if state != State::WaitingForJobset {
                    return Err(OpError::Error(format!(
                        "jobset {}/{} failed",
                        project_name, jobset_name
                    )));
                }
            }
            Ok(jobset) => match state {
                State::WaitingForJobset => {
                    state = State::WaitingForPreviousEval;
                    println!("waiting for a potential evaluation to terminate");
                }
                State::WaitingForPreviousEval => match evaluation_started_since(&jobset) {
                    Some(_) => {}
                    None => {
                        println!("\nwaiting for an new evaluation");
                        start = SystemTime::now();
                        state = State::WaitingForNewEval;
                    }
                },
                State::WaitingForNewEval => {
                    if is_evaluation_finished_after(&jobset, start) {
                        println!("\njobset has been evaluated");
                        // we skip the evaluation step since the evaluation is already finished
                        state = State::Building;
                    } else if let Some(d) = evaluation_started_since(&jobset) {
                        println!(
                            "\nevaluation is started since {} seconds",
                            d.as_secs().to_string()
                        );
                        state = State::Evaluating;
                    }
                }
                State::Evaluating => {
                    if is_evaluation_finished_after(&jobset, start) {
                        println!("\njobset has been evaluated");
                        state = State::Building;
                    }
                }
                State::Building => {
                    if is_jobset_built(client, &jobset)? {
                        break;
                    } else if nrscheduled != jobset.nrscheduled {
                        nrscheduled = jobset.nrscheduled;
                        println!(
                            "\njobset {} has still {} jobs scheduled",
                            jobset_name.to_string(),
                            jobset.nrscheduled.to_string()
                        );
                    }
                }
            },
        };
        print!(".");
        io::stdout().flush().unwrap();
        thread::sleep(sleep);
    }
    ok()
}
