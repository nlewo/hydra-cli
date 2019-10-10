use serde::de::{self, Deserialize, Deserializer, Unexpected};
use serde::{Serialize, Serializer};
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

#[derive(Serialize, Deserialize, PartialEq, Debug)]
pub struct Project {
    #[serde(deserialize_with = "bool_from_int")]
    pub enabled: bool,
    pub name: String,
    pub description: Option<String>,
    #[serde(deserialize_with = "bool_from_int")]
    pub hidden: bool,
    pub owner: String,
    pub displayname: String,
    pub jobsets: Vec<String>,
}

fn bool_from_int<'de, D>(deserializer: D) -> Result<bool, D::Error>
where
    D: Deserializer<'de>,
{
    match u8::deserialize(deserializer)? {
        0 => Ok(false),
        1 => Ok(true),
        other => Err(de::Error::invalid_value(
            Unexpected::Unsigned(u64::from(other)),
            &"zero or one",
        )),
    }
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
    pub lastcheckedtime: Option<PosixTimestamp>,
    pub haserrormsg: Option<bool>,
}

#[derive(PartialEq, Debug)]
#[repr(u8)]
pub enum JobsetEnabled {
    Disabled = 0,
    Enabled = 1,
    OneShot = 2,
}

impl Serialize for JobsetEnabled {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        serializer.serialize_u8(match self {
            JobsetEnabled::Disabled => 0,
            JobsetEnabled::Enabled => 1,
            JobsetEnabled::OneShot => 2,
        })
    }
}

impl<'de> Deserialize<'de> for JobsetEnabled {
    fn deserialize<D>(deserializer: D) -> Result<JobsetEnabled, D::Error>
    where
        D: Deserializer<'de>,
    {
        match u8::deserialize(deserializer)? {
            0 => Ok(JobsetEnabled::Disabled),
            1 => Ok(JobsetEnabled::Enabled),
            2 => Ok(JobsetEnabled::OneShot),
            other => Err(de::Error::invalid_value(
                Unexpected::Unsigned(u64::from(other)),
                &"zero, one, or two",
            )),
        }
    }
}

#[derive(Serialize, Deserialize, Debug)]
pub struct JobsetConfig {
    pub description: String,
    pub checkinterval: i64,
    pub enabled: JobsetEnabled,
    pub visible: bool,
    pub keepnr: i64,
    pub nixexprinput: String,
    pub nixexprpath: String,
    pub inputs: HashMap<String, Input>,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ProjectConfig {
    pub displayname: String,
    pub enabled: bool,
    pub visible: bool,
}
