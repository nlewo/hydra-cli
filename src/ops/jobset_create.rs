use crate::hydra::JobsetConfig;
use crate::ops::{ok_msg, OpError, OpResult};
use reqwest::header::REFERER;
use reqwest::Response;
use std::collections::HashMap;
use std::fs::read_to_string;

fn load_config(config_path: &str) -> JobsetConfig {
    let cfg = read_to_string(config_path).expect("Failed to read config file");
    serde_json::from_str(&cfg).expect("Failed to parse jobset configuration")
}

fn login(
    client: &reqwest::Client,
    host: &str,
    user: &str,
    password: &str,
) -> reqwest::Result<Response> {
    let login_request_url = format!("{host}/login", host = host);
    let creds: HashMap<&str, &str> = [("username", user), ("password", password)]
        .iter()
        .cloned()
        .collect();
    client
        .post(&login_request_url)
        .header(REFERER, host)
        .json(&creds)
        .send()
}

fn create_jobset(
    client: &reqwest::Client,
    host: &str,
    jobset_config: &JobsetConfig,
    project: &str,
    jobset: &str,
) -> reqwest::Result<Response> {
    let jobset_request_url = format!(
        "{host}/jobset/{project}/{jobset}",
        host = host,
        project = project,
        jobset = jobset
    );
    client
        .put(&jobset_request_url)
        .header(REFERER, host)
        .json(&jobset_config)
        .send()
}

pub fn run(
    host: &str,
    config_path: &str,
    project_name: &str,
    jobset_name: &str,
    user: &str,
    password: &str,
) -> OpResult {
    println!(
        "Creating jobset '{}' in project '{}' on host '{}' ...",
        jobset_name, project_name, host
    );
    let client = reqwest::Client::builder().cookie_store(true).build()?;
    let cfg = load_config(config_path);
    let res = login(&client, host, user, password)?;

    if res.status().is_success() {
        create_jobset(&client, host, &cfg, project_name, jobset_name)?;
        ok_msg("jobset created")
    } else {
        Err(OpError::AuthError)
    }
}
