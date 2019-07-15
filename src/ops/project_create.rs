use crate::hydra::ProjectConfig;
use crate::ops::{ok_msg, OpResult};
use reqwest::header::REFERER;
use reqwest::Response;
use std::collections::HashMap;

fn create_project(
    client: &reqwest::Client,
    host: &str,
    project: &str,
) -> reqwest::Result<Response> {
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
        .send()
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

pub fn run(host: &str, project_name: &str, user: &str, password: &str) -> OpResult {
    println!("Creating project '{}' on host '{}' ...", project_name, host);

    let client = reqwest::Client::builder().cookie_store(true).build()?;
    login(&client, host, user, password)?;
    create_project(&client, host, project_name)?;

    ok_msg("project created")
}
