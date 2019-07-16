use crate::hydra::ProjectConfig;
use crate::ops::{ok_msg, OpError, OpResult};
use crate::query::login;
use reqwest::header::REFERER;
use reqwest::Response;

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

pub fn run(host: &str, project_name: &str, user: &str, password: &str) -> OpResult {
    println!("Creating project '{}' on host '{}' ...", project_name, host);

    let client = reqwest::Client::builder().cookie_store(true).build()?;
    let res = login(&client, host, user, password)?;

    if res.status().is_success() {
        create_project(&client, host, project_name)?;
        ok_msg("project created")
    } else {
        Err(OpError::AuthError)
    }
}
