use crate::ops::{OpResult, OpError};
use crate::hydra::JobsetOverview;
use crate::query::jobset_overview;
use std::time::SystemTime;
use std::time::{Duration, UNIX_EPOCH};
use std::{thread};
use std::option::Option;
use std::io;
use std::io::Write;

fn evaluation_started_since(jobset: &JobsetOverview) -> Option<Duration> {
    let starttime = jobset.starttime?;
    match SystemTime::now().duration_since(UNIX_EPOCH + Duration::from_secs(starttime)) {
        Ok(n) => Some(n),
        Err(_) => None
    }
}

fn jobset_find(host: &str, project_name: &str, jobset_name: &str) -> Result<JobsetOverview, OpError> {
    let jobsets = jobset_overview(host, project_name)?;
    jobsets
        .into_iter()
        .find(|j| j.name == jobset_name)
        .ok_or_else(|| OpError::Error(
            format!("Project {} doesn't have a jobset {}",
                    project_name,
                    jobset_name)))
}

// To know if a jobset has been successfully built, four steps are required:
// 1. ensure a evaluation is not running
// 2. wait for a new evaluation to start
// 3. wait for this evaluation to be terminated
// 4. wait for all scheduled builds to terminate
//
// If a build or the evaluation fail, it immediately returns an error.
//
// There are several improvements, such as
// - use the checkinterval to know when the next evaluation will start
// - use the push Hydra API to trigger an evaluation (but this needs credentials)
pub fn run(host: &str, project_name: &str, jobset_name: &str) -> OpResult {
    enum State {
        WaitingForPreviousEval,
        WaitingForNewEval,
        Evaluating,
        Building,
    };
    let sleep = 2;
    let mut state = State::WaitingForPreviousEval;
    let mut start = SystemTime::now();
    let mut nrscheduled = 0;

    println!("waiting for a potential evaluation to terminate");
    loop {
        let jobset = jobset_find(host, project_name, jobset_name)?;
        match state {
            State::WaitingForPreviousEval => {
                match evaluation_started_since(&jobset) {
                    Some(_) => {}
                    None => {
                        println!("\nwaiting for an new evaluation");
                        state = State::WaitingForNewEval;
                        start = SystemTime::now();
                    }
                }
            },
            State::WaitingForNewEval => {
                if (UNIX_EPOCH + Duration::from_secs(jobset.lastcheckedtime)) > start {
                    println!("\njobset has been evaluated");
                    // we skip the evaluation step since the evaluation is already finished
                    state = State::Building;
                } else if let Some(d) = evaluation_started_since(&jobset) {
                        println!("\nevaluation is started since {} seconds", d.as_secs().to_string());
                        state = State::Evaluating;
                }
            },
            State::Evaluating =>
                if (UNIX_EPOCH + Duration::from_secs(jobset.lastcheckedtime)) > start {
                    println!("\njobset has been evaluated");
                    state = State::Building;
                },
            State::Building => {
                if jobset.errormsg != "" {
                    println!();
                    return Err(OpError::Error(
                        format!("evaluation of jobset {} failed",
                                jobset_name)));
                }
                if jobset.nrfailed != 0 {
                    println!();
                    return Err(OpError::Error(
                        format!("Jobset {} has {} failed jobs",
                                jobset_name,
                                jobset.nrfailed.to_string())));
                }
                if jobset.nrsucceeded == jobset.nrtotal {
                    println!("\nall jobs of jobset {} have been built", jobset_name.to_string());
                    return Ok(None)
                } else if nrscheduled != jobset.nrscheduled {
                    nrscheduled = jobset.nrscheduled;
                    println!("\njobset {} has still {} jobs scheduled", jobset_name.to_string(), jobset.nrscheduled.to_string());
                }
            }
        }
        print!(".");
        io::stdout().flush().unwrap();
        thread::sleep(Duration::from_secs(sleep));        
    } 
}
