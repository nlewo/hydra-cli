use serde::{Deserialize, Serialize};
pub use serde_json::Value;
use std::collections::HashMap;

#[derive(Serialize, Deserialize, Debug)]
pub struct Input {
    pub value: Option<String>,
    #[serde(rename = "type")]
    pub input_type: String,
    pub revision: Option<String>,
    pub uri: Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Eval {
    pub jobsetevalinputs: HashMap<String, Input>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Jobset {
    pub nixexprpath: String,
    pub nixexprinput: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Path {
    pub path: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Build {
    pub id: i64,
    pub project: String,
    pub drvpath: String,
    pub job: String,
    pub jobset: String,
    pub buildoutputs: HashMap<String, Path>,
    pub stoptime: i64,
    pub jobsetevals: Vec<i64>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Search {
    pub builds: Vec<Build>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Reproduce {
    pub build: Build,
    pub eval: Eval,
    pub jobset: Jobset,
}

pub type PosixTimestamp = u64;

#[derive(Serialize, Deserialize, Debug)]
pub struct JobsetOverview {
    pub nrscheduled: i64,
    pub nrtotal: i64,
    pub nrsucceeded: i64,
    pub project: String,
    pub name: String,
    pub nrfailed: i64,
    pub starttime: Option<PosixTimestamp>,
    pub lastcheckedtime: PosixTimestamp,
    pub errormsg: String,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct JobsetConfig {
    pub description: String,
    pub checkinterval: i64,
    enabled: bool,
    visible: bool,
    keepnr: i64,
    nixexprinput: String,
    nixexprpath: String,
    inputs: HashMap<String, Input>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ProjectConfig {
    pub displayname: String,
    pub enabled: bool,
    pub visible: bool,
}
