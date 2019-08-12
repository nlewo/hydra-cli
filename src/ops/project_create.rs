use crate::hydra::client::{Creds, HydraClient};
use crate::ops::{ok_msg, OpResult};

pub fn run(client: &HydraClient, project_name: &str, user: &str, password: &str) -> OpResult {
    let creds = Creds {
        user: String::from(user),
        password: String::from(password),
    };

    client.login(creds)?;
    client.project_create(project_name)?;

    ok_msg("project_create")
}
