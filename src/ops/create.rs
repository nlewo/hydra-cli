use crate::hydra::{JobsetConfig, ProjectConfig};
use reqwest::header::REFERER;
use reqwest::Error;
use std::collections::HashMap;
use std::fs::read_to_string;

fn login(client: &reqwest::Client, host: &str, user: &str, password: &str) -> Result<(), Error> {
    let login_request_url = format!("{host}/login", host = host);
    let creds: HashMap<&str, &str> = [("username", user), ("password", password)]
        .iter()
        .cloned()
        .collect();
    client
        .post(&login_request_url)
        .header(REFERER, host)
        .json(&creds)
        .send()?;
    Ok(())
}

fn create_project(client: &reqwest::Client, host: &str, project: &str) -> Result<(), Error> {
    let create_proj_url = format!("{host}/project/{project}", host = host, project = project);
    let proj: ProjectConfig = ProjectConfig {
        displayname: String::from(project),
        enabled: true,
        visible: true,
    };
    client
        .put(&create_proj_url)
        .header(REFERER, host)
        .json(&proj)
        .send()?;
    Ok(())
}

fn create_jobset(
    client: &reqwest::Client,
    host: &str,
    config: &str,
    project: &str,
    jobset: &str,
) -> Result<(), Error> {
    let config_str = read_to_string(config).unwrap();
    let jobset_cfg: JobsetConfig = serde_json::from_str(&config_str).unwrap();

    let jobset_request_url = format!(
        "{host}/jobset/{project}/{jobset}",
        host = host,
        project = project,
        jobset = jobset
    );
    client
        .put(&jobset_request_url)
        .header(REFERER, host)
        .json(&jobset_cfg)
        .send()?;
    Ok(())
}

pub fn run(
    host: &str,
    config: &str,
    project: &str,
    jobset: &str,
    user: &str,
    password: &str,
) -> Result<(), Error> {
    println!("Creating jobset '{}' in project '{}'", jobset, project);
    let client = reqwest::Client::builder().cookie_store(true).build()?;

    login(&client, host, user, password)?;
    create_project(&client, host, project)?;
    create_jobset(&client, host, config, project, jobset)?;

    Ok(())
}
