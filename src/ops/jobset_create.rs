use crate::hydra::client::{Creds, HydraClient, JobsetConfig};
use crate::ops::{ok_msg, OpResult};
use std::fs::read_to_string;

fn load_config(config_path: &str) -> JobsetConfig {
    let cfg = read_to_string(config_path).expect("Failed to read config file");
    serde_json::from_str(&cfg).expect("Failed to parse jobset configuration")
}

pub fn run(
    client: &dyn HydraClient,
    config_path: &str,
    project_name: &str,
    jobset_name: &str,
    user: &str,
    password: &str,
) -> OpResult {
    let jobset_cfg = load_config(config_path);
    let creds = Creds {
        username: String::from(user),
        password: String::from(password),
    };

    client.login(creds)?;
    client.jobset_create(project_name, jobset_name, &jobset_cfg)?;

    ok_msg("jobset__create")
}
