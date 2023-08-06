use crate::hydra::client::*;

use reqwest::blocking::Client as ReqwestClient;
use reqwest::header::REFERER;
use serde::de::DeserializeOwned;
use serde_json::Value;
#[cfg(test)]
use std::collections::HashMap;

#[cfg(test)]
use mockito;

#[cfg(test)]
use crate::hydra::types::JobsetEnabled;

impl From<reqwest::Error> for ClientError {
    fn from(e: reqwest::Error) -> Self {
        let msg = format!("{}", e);
        ClientError::Error(msg)
    }
}

#[derive(Clone)]
pub struct Client {
    pub host: String,
    pub client: ReqwestClient,
}

impl Client {
    pub fn new(client: ReqwestClient, host: String) -> Client {
        Client { client, host }
    }
}

/// Performs a GET request retrieving a deserializable response
fn get_json<T: DeserializeOwned>(client: &ReqwestClient, url: &str) -> Result<T, ClientError> {
    let res = client
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

impl HydraClient for Client {
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
            .header(REFERER, self.host.as_str())
            .json(&proj)
            .send()?;

        if res.status().is_success() {
            Ok(())
        } else {
            Err(ClientError::Error(format!("{}", res.status())))
        }
    }

    fn host(&self) -> String {
        self.host.clone()
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
            .header(REFERER, self.host.as_str())
            .json(&jobset_config)
            .send()?;

        if res.status().is_success() {
            Ok(())
        } else {
            Err(ClientError::Error(format!("{}", res.status())))
        }
    }

    fn jobset_eval(&self, project_name: &str, jobset_name: &str) -> Result<(), ClientError> {
        let request_url = format!(
            "{}/api/push?jobsets={}:{}",
            &self.host, project_name, jobset_name
        );
        let res = self
            .client
            .put(&request_url)
            .header(REFERER, self.host.as_str())
            .send()?;

        if res.status().is_success() {
            Ok(())
        } else {
            Err(ClientError::Error(format!("{}", res.status())))
        }
    }

    fn login(&self, creds: Creds) -> Result<(), ClientError> {
        let login_request_url = format!("{}/login", &self.host);
        let login_res = self
            .client
            .post(&login_request_url)
            .header(REFERER, self.host.as_str())
            .json(&creds)
            .send();

        match login_res {
            Ok(r) => {
                if r.status().is_success() {
                    Ok(())
                } else if r.status().is_redirection() {
                    Ok(())
                } else {
                    Err(ClientError::Error(format!("Response Error: {}", r.status())))
                }
            }
            Err(err) => Err(ClientError::Error(format!("Request Error: {}", err))),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use mockito::{mock, Matcher};

    fn client() -> Client {
        let url = &mockito::server_url();
        let c = reqwest::blocking::Client::builder()
            .cookie_store(true)
            .build()
            .unwrap();

        Client::new(c, String::from(url))
    }

    #[test]
    fn get_json_yields_err_on_non_200_response() {
        let _m = mock("GET", "/")
            .with_status(500)
            .with_header("content-type", "application/json")
            .with_body("[]")
            .create();

        let c = client();
        let res: Result<Project, ClientError> = get_json(&c.client, &c.host);
        assert_eq!(
            res,
            Err(ClientError::Error("500 Internal Server Error".to_string()))
        );
    }

    #[test]
    fn get_json_yields_invalid_response_on_invalid_json() {
        let _m = mock("GET", "/")
            .with_status(200)
            .with_header("content-type", "application/json")
            .with_body("a{x")
            .create();

        let c = client();
        let res: Result<Vec<Project>, ClientError> = get_json(&c.client, &c.host);

        assert_eq!(
            res,
            Err(ClientError::Error(
                "error decoding response body: expected value at line 1 column 1".to_string()
            ))
        )
    }

    #[test]
    fn projects_lists_single_project() {
        let _m = mock("GET", "/")
            .with_status(200)
            .with_header("content-type", "application/json")
            .with_body("[{ \"owner\": \"admin\", \"displayname\": \"hydra-cli\", \"hidden\": 0, \"description\": \"Hydra Command Line Interface\", \"jobsets\": [ \"20\", \"21\"], \"releases\": [], \"enabled\": 1, \"name\": \"hydra-cli\" } ]")
            .create();

        let ps = client().projects();
        assert_eq!(
            ps.unwrap(),
            vec![Project {
                enabled: true,
                name: "hydra-cli".to_string(),
                displayname: "hydra-cli".to_string(),
                hidden: false,
                owner: "admin".to_string(),
                description: Some("Hydra Command Line Interface".to_string()),
                jobsets: vec!["20".to_string(), "21".to_string()]
            }]
        );
    }

    #[test]
    fn login_posts_creds_to_login_path() {
        let _m = mock("POST", "/login")
            .with_status(200)
            .match_body(Matcher::JsonString(
                "{\"username\": \"user\", \"password\": \"pw\"}".to_string(),
            ))
            .create();

        let res = client().login(Creds {
            username: "user".to_string(),
            password: "pw".to_string(),
        });
        assert_eq!(res.unwrap(), ())
    }

    #[test]
    fn login_yields_err_when_response_status_is_not_200() {
        let _m = mock("POST", "/login")
            .with_status(500)
            .match_body(Matcher::JsonString(
                "{\"username\": \"user\", \"password\": \"pw\"}".to_string(),
            ))
            .create();

        let res = client().login(Creds {
            username: "user".to_string(),
            password: "pw".to_string(),
        });

        assert_eq!(
            res,
            Err(ClientError::Error("Response Error: 500 Internal Server Error".to_string()))
        );
    }

    #[test]
    fn jobset_create_posts_config_to_correct_path() {
        let jobset = JobsetConfig {
            description: "desc".to_string(),
            checkinterval: 100,
            enabled: JobsetEnabled::Enabled,
            visible: true,
            nixexprinput: "input".to_string(),
            nixexprpath: "path".to_string(),
            keepnr: 10,
            inputs: HashMap::new(),
        };
        let _m = mock("PUT", "/jobset/foo-project/foo-jobset")
            .with_status(200)
            .match_body(Matcher::JsonString(serde_json::to_string(&jobset).unwrap()))
            .create();

        let res = client().jobset_create("foo-project", "foo-jobset", &jobset);
        assert_eq!(res.unwrap(), ())
    }

    #[test]
    fn jobset_create_yields_err_when_response_status_is_not_200() {
        let jobset = JobsetConfig {
            description: "desc".to_string(),
            checkinterval: 100,
            enabled: JobsetEnabled::Enabled,
            visible: true,
            nixexprinput: "input".to_string(),
            nixexprpath: "path".to_string(),
            keepnr: 10,
            inputs: HashMap::new(),
        };
        let _m = mock("PUT", "/jobset/foo-project/foo-jobset")
            .with_status(500)
            .match_body(Matcher::JsonString(serde_json::to_string(&jobset).unwrap()))
            .create();

        let res = client().jobset_create("foo-project", "foo-jobset", &jobset);
        assert_eq!(
            res,
            Err(ClientError::Error("500 Internal Server Error".to_string()))
        );
    }
}
