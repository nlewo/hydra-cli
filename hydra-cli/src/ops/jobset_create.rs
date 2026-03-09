use crate::hydra::client::{Creds, HydraClient, JobsetConfig};
use crate::ops::{ok_msg, OpError, OpResult};
use std::fs::read_to_string;

fn validate_config(jobset_cfg: &JobsetConfig) -> Result<(), OpError> {
    if jobset_cfg.nixexprinput.is_none() {
        if jobset_cfg.jobset_type != Some(1) {
            return Err(OpError::Error(
                "Missing nixexprinput requires `type` set to 1".to_string(),
            ));
        }

        if jobset_cfg.flake.is_none() {
            return Err(OpError::Error(
                "Missing nixexprinput requires a `flake` key".to_string(),
            ));
        }
    }

    Ok(())
}

fn load_config(config_path: &str) -> Result<JobsetConfig, OpError> {
    let cfg = read_to_string(config_path)
        .map_err(|e| OpError::Error(format!("Failed to read config file: {}", e)))?;
    let jobset_cfg: JobsetConfig = serde_json::from_str(&cfg)
        .map_err(|e| OpError::Error(format!("Failed to parse jobset configuration: {}", e)))?;

    validate_config(&jobset_cfg)?;
    Ok(jobset_cfg)
}

#[cfg(test)]
mod test {
    use super::validate_config;
    use crate::hydra::client::JobsetConfig;

    #[test]
    fn accepts_legacy_nixexpr_config() {
        let cfg: JobsetConfig = serde_json::from_str(
            r#"{
  "description": "desc",
  "checkinterval": 60,
  "enabled": 1,
  "visible": true,
  "keepnr": 3,
  "nixexprinput": "src",
  "nixexprpath": "default.nix",
  "inputs": {}
}"#,
        )
        .unwrap();

        assert!(validate_config(&cfg).is_ok());
    }

    #[test]
    fn accepts_flake_config_without_nixexprinput() {
        let cfg: JobsetConfig = serde_json::from_str(
            r#"{
  "type": 1,
  "description": "desc",
  "checkinterval": 60,
  "enabled": 1,
  "visible": true,
  "keepnr": 3,
  "flake": "github:org/repo"
}"#,
        )
        .unwrap();

        assert!(validate_config(&cfg).is_ok());
    }

    #[test]
    fn rejects_missing_nixexprinput_without_flake_type() {
        let cfg: JobsetConfig = serde_json::from_str(
            r#"{
  "description": "desc",
  "checkinterval": 60,
  "enabled": 1,
  "visible": true,
  "keepnr": 3
}"#,
        )
        .unwrap();

        assert!(validate_config(&cfg).is_err());
    }
}

pub fn run(
    client: &dyn HydraClient,
    config_path: &str,
    project_name: &str,
    jobset_name: &str,
    user: &str,
    password: &str,
) -> OpResult {
    let jobset_cfg = load_config(config_path)?;
    let creds = Creds {
        username: String::from(user),
        password: String::from(password),
    };

    client.login(creds)?;
    client.jobset_create(project_name, jobset_name, &jobset_cfg)?;

    ok_msg("jobset__create")
}
