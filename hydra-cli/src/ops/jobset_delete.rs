use crate::hydra::client::{Creds, HydraClient};
use crate::ops::{ok_msg, OpResult};

pub fn run(
    client: &dyn HydraClient,
    project_name: &str,
    jobset_name: &str,
    user: &str,
    password: &str,
) -> OpResult {
    let creds = Creds {
        username: String::from(user),
        password: String::from(password),
    };

    client.login(creds)?;
    client.jobset_delete(project_name, jobset_name)?;

    ok_msg("jobset_delete")
}
