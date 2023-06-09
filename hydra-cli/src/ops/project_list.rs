use crate::hydra::client::{HydraClient, Project};
use crate::ops::{ok_msg, OpResult};
use prettytable::format;

pub fn run(client: &dyn HydraClient, to_json: bool) -> OpResult {
    let res: Vec<Project> = client.projects()?;
    if to_json {
        println!("{}", serde_json::to_string_pretty(&res).unwrap())
    } else {
        let mut table = table!(["Name", "Enable", "Visible", "#Jobsets", "Description"]);
        table.set_format(*format::consts::FORMAT_CLEAN);
        for p in res {
            table.add_row(row![
                p.name,
                p.enabled,
                !p.hidden,
                p.jobsets.len(),
                p.description.unwrap_or_else(|| "".to_string())
            ]);
        }
        table.printstd();
    };
    ok_msg("projects listed")
}
