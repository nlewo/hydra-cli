use crate::hydra::JobsetOverview;
use crate::query::jobsetOverview;
use prettytable::format;
use reqwest::Error;

pub fn render_response(res: std::vec::Vec<JobsetOverview>) {
    let mut table = table!(["Jobset", "Succeeded", "Scheduled", "Failed"]);
    table.set_format(*format::consts::FORMAT_CLEAN);
    for j in res {
        let mut nrfailed = j.nrfailed.to_string();
        let mut nrscheduled = j.nrscheduled.to_string();
        let mut name = j.name;
        if j.nrfailed == 0 {
            nrfailed = "".to_string();
        }
        if j.nrscheduled == 0 {
            nrscheduled = "".to_string();
        }
        table.add_row(row![name, j.nrsucceeded, nrscheduled, nrfailed]);
    }
    table.printstd();
}

pub fn run(host: &str, project: &str, to_json: bool) -> Result<(), Error> {
    let res = jobsetOverview(host, project)?;
    if to_json {
        println!("{}", serde_json::to_string(&res).unwrap())
    } else {
        render_response(res)
    };
    Ok(())
}
