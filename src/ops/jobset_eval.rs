use crate::hydra::client::{Creds, HydraClient};
use crate::ops::{ok_msg, OpResult};

pub fn run(client: &dyn HydraClient, project_name: &str, jobset_name: &str) -> OpResult {
    client.jobset_eval(project_name, jobset_name)?;

    ok_msg("jobset_eval")
}
