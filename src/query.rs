use crate::hydra::{Eval, Jobset, JobsetOverview, Search};
use reqwest::Error;
use serde::de::DeserializeOwned;
use serde_json::Value;

fn query<T: DeserializeOwned>(request_url: String) -> Result<T, Error> {
    debug!("Request url: {}", request_url);
    let client = reqwest::Client::new();
    let mut res = client
        .get(&request_url)
        .header(reqwest::header::CONTENT_TYPE, "application/json")
        .send()?;

    let v: Value = res.json()?;
    let res = serde_json::from_value(v).unwrap();
    Ok(res)
}

pub fn eval(host: String, number: i64) -> Result<Eval, Error> {
    let request_url = format!("{host}/eval/{number}", host = host, number = number);
    let res: Eval = query(request_url)?;
    Ok(res)
}

pub fn jobsetOverview(host: &str, project: &str) -> Result<Vec<JobsetOverview>, Error> {
    let request_url = format!(
        "{host}/api/jobsets?project={project}",
        host = host,
        project = project
    );
    let res: Vec<JobsetOverview> = query(request_url)?;
    Ok(res)
}

pub fn jobset(host: String, project: String, jobset: String) -> Result<Jobset, Error> {
    let request_url = format!(
        "{host}/jobset/{project}/{jobset}",
        host = host,
        project = project,
        jobset = jobset
    );
    let res: Jobset = query(request_url)?;
    Ok(res)
}

pub fn search(host: &str, queri: &str, limit: usize) -> Result<Search, Error> {
    let request_url = format!("{host}/search?query={query}", host = host, query = queri);
    let mut search: Search = query(request_url)?;
    // TODO: implement limit in Hydra API
    if search.builds.len() > limit {
        search.builds = search.builds[0..limit].to_vec();
    }
    debug!("{:?}", search);
    Ok(search)
}
