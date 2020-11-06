//! Hydra CI REST API Library
//!
//! The HydraClient trait includes operations for querying and creating resources on
//! a Hydra endpoint.

pub use crate::hydra::types::{
    Build, Eval, Jobset, JobsetConfig, JobsetOverview, Project, ProjectConfig, Reproduce, Search,
};
use crate::ops::OpError;
use serde::{Deserialize, Serialize};

/// Stores combination of user and password as required by login
#[derive(Serialize, Deserialize)]
pub struct Creds {
    pub username: String,
    pub password: String,
}

/// Errors occuring while talking to the hydra endpoint
#[derive(PartialEq, Debug)]
pub enum ClientError {
    /// Generic error
    Error(String),
    /// Received data that could not be parsed
    InvalidResponse(String),
}

impl From<ClientError> for OpError {
    fn from(e: ClientError) -> Self {
        match e {
            ClientError::Error(s) => OpError::RequestError(s),
            ClientError::InvalidResponse(s) => OpError::RequestError(s),
        }
    }
}

pub trait HydraClient {
    /// Authenticates with the server using username and password provided by `Creds`
    fn login(&self, creds: Creds) -> Result<(), ClientError>;

    /// Searches the host for the nix store path `query`
    fn search(&self, query: &str) -> Result<Search, ClientError>;

    /// Retrieves evaluation information for the build specified by `number`
    fn eval(&self, number: i64) -> Result<Eval, ClientError>;

    /// Retrieves the jobset specified by `project` / `jobset`
    fn jobset(&self, project: &str, jobset: &str) -> Result<Jobset, ClientError>;

    /// Creates a jobset called `jobset_name` in the project `project_name` using
    /// the configuration from `jobset_config`
    fn jobset_create(
        &self,
        project_name: &str,
        jobset_name: &str,
        jobset_config: &JobsetConfig,
    ) -> Result<(), ClientError>;

    /// Evaluate a jobset called `jobset_name` in the project `project_name`
    fn jobset_eval(&self, project_name: &str, jobset_name: &str) -> Result<(), ClientError>;

    /// Retrieves information on all jobsets belonging to `project`
    fn jobset_overview(&self, project: &str) -> Result<Vec<JobsetOverview>, ClientError>;

    /// Retrieves all configured projects
    fn projects(&self) -> Result<Vec<Project>, ClientError>;

    /// Retrieves a project given by `name`
    fn project_create(&self, name: &str) -> Result<(), ClientError>;
}
