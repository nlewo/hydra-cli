use crate::hydra::{Eval, Jobset, JobsetConfig, JobsetOverview, Project, ProjectConfig, Search};
use crate::ops::OpError;
use reqwest::header::REFERER;
use reqwest::Client as ReqwestClient;
use serde::de::DeserializeOwned;
use serde_json::Value;
use std::collections::HashMap;

pub struct Creds {
    pub user: String,
    pub password: String,
}

pub enum ClientError {
    Error(String),
    InvalidResponse(String),
}

// TODO: implement this properly
impl From<ClientError> for OpError {
    fn from(e: ClientError) -> Self {
        match e {
            ClientError::Error(s) => OpError::RequestError(s),
            ClientError::InvalidResponse(s) => OpError::RequestError(s),
        }
    }
}

impl From<reqwest::Error> for ClientError {
    fn from(e: reqwest::Error) -> Self {
        let msg = format!("{}", e);
        ClientError::Error(msg)
    }
}

#[derive(Clone)]
pub struct HydraRestClient<T> {
    host: String,
    client: T,
}

impl HydraRestClient<ReqwestClient> {
    pub fn new(client: ReqwestClient, host: String) -> HydraRestClient<ReqwestClient> {
        HydraRestClient { client, host }
    }
}

pub trait HydraClient {
    fn login(&self, creds: Creds) -> Result<(), ClientError>;
    fn search(&self, query: &str) -> Result<Search, ClientError>;
    fn eval(&self, number: i64) -> Result<Eval, ClientError>;
    fn jobset(&self, project: &str, jobset: &str) -> Result<Jobset, ClientError>;
    fn jobset_create(
        &self,
        project_name: &str,
        jobset_name: &str,
        jobset_config: &JobsetConfig,
    ) -> Result<(), ClientError>;
    fn jobset_overview(&self, project: &str) -> Result<Vec<JobsetOverview>, ClientError>;
    fn projects(&self) -> Result<Vec<Project>, ClientError>;
    fn project_create(&self, name: &str) -> Result<(), ClientError>;
    fn host(&self) -> String;
}

fn get_json<T: DeserializeOwned>(client: &ReqwestClient, url: &str) -> Result<T, ClientError> {
    let mut res = client
        .get(url)
        .header(reqwest::header::CONTENT_TYPE, "application/json")
        .send()?;

    if res.status().is_success() {
        let v: Value = res.json()?;
        match serde_json::from_value(v) {
            Ok(x) => Ok(x),
            Err(x) => Err(ClientError::InvalidResponse(format!("{}", x))),
        }
    } else {
        Err(ClientError::Error(format!("{}", res.status())))
    }
}

impl HydraClient for HydraRestClient<ReqwestClient> {
    fn host(&self) -> String {
        self.host.clone()
    }

    fn project_create(&self, name: &str) -> Result<(), ClientError> {
        let create_proj_url = format!("{}/project/{}", &self.host, name);
        let proj: ProjectConfig = ProjectConfig {
            displayname: String::from(name),
            enabled: true,
            visible: true,
        };
        let res = self
            .client
            .put(&create_proj_url)
            .header(REFERER, self.host.clone())
            .json(&proj)
            .send()?;

        if res.status().is_success() {
            Ok(())
        } else {
            Err(ClientError::Error(format!("{}", res.status())))
        }
    }

    fn projects(&self) -> Result<Vec<Project>, ClientError> {
        get_json(&self.client, &self.host)
    }

    fn search(&self, query: &str) -> Result<Search, ClientError> {
        let request_url = format!("{}/search?query={}", &self.host, query);
        get_json(&self.client, &request_url)
    }

    fn jobset_overview(&self, project: &str) -> Result<Vec<JobsetOverview>, ClientError> {
        let request_url = format!("{}/api/jobsets?project={}", &self.host, project);
        get_json(&self.client, &request_url)
    }

    fn jobset(&self, project: &str, jobset: &str) -> Result<Jobset, ClientError> {
        let request_url = format!("{}/jobset/{}/{}", &self.host, project, jobset);
        get_json(&self.client, &request_url)
    }

    fn eval(&self, number: i64) -> Result<Eval, ClientError> {
        let request_url = format!("{}/eval/{}", &self.host, number);
        get_json(&self.client, &request_url)
    }

    fn jobset_create(
        &self,
        project_name: &str,
        jobset_name: &str,
        jobset_config: &JobsetConfig,
    ) -> Result<(), ClientError> {
        let request_url = format!("{}/jobset/{}/{}", &self.host, project_name, jobset_name);
        let res = self
            .client
            .put(&request_url)
            .header(REFERER, self.host.clone())
            .json(&jobset_config)
            .send()?;

        if res.status().is_success() {
            Ok(())
        } else {
            Err(ClientError::Error(format!("{}", res.status())))
        }
    }

    fn login(&self, creds: Creds) -> Result<(), ClientError> {
        let login_request_url = format!("{}/login", &self.host);
        let creds: HashMap<String, String> = [
            (String::from("username"), creds.user),
            (String::from("password"), creds.password),
        ]
        .iter()
        .cloned()
        .collect();

        let login_res = self
            .client
            .post(&login_request_url)
            .header(REFERER, self.host.clone())
            .json(&creds)
            .send();

        match login_res {
            Ok(r) => {
                if r.status().is_success() {
                    Ok(())
                } else {
                    Err(ClientError::Error(String::from("")))
                }
            }
            Err(_) => Err(ClientError::Error(String::from(""))),
        }
    }
}
