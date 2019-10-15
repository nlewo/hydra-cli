//! Examples intended for the CLI help sections

pub use crate::hydra::types::{Input, JobsetConfig, JobsetEnabled};
use std::collections::HashMap;

pub fn jobset_config() -> JobsetConfig {
    JobsetConfig {
        description: "hydra-cli master jobset".to_string(),
        checkinterval: 60,
        enabled: JobsetEnabled::Enabled,
        visible: true,
        keepnr: 3,
        nixexprinput: "src".to_string(),
        nixexprpath: "default.nix".to_string(),
        inputs: {
            let mut map = HashMap::<String, Input>::new();
            let input = Input {
                value: Some("https://github.com/nlewo/hydra-cli.git master".to_string()),
                input_type: "git".to_string(),
                revision: None,
                uri: None,
            };
            map.insert("src".to_string(), input);
            map
        },
    }
}
