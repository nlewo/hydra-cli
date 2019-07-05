use crate::hydra::{Reproduce, Search};
use crate::pretty::{build_pretty_print, evaluation_pretty_print};
use crate::query::{eval, jobset, search};
use reqwest::Error;

pub fn run(host: &str, query: &str, to_json: bool) -> Result<(), Error> {
    let mut res: Search = search(host, query, 1)?;

    if res.builds.is_empty() {
        println!("No builds found. Exiting.");
        return Ok(());
    } else if res.builds.len() > 1 {
        eprintln!(
            "Warning: the query matches {} builds, considering the first one.",
            res.builds.len()
        );
    }
    let eval = eval(host.to_string(), res.builds[0].jobsetevals[0])?;
    let jobset = jobset(
        host.to_string(),
        res.builds[0].project.to_string(),
        res.builds[0].jobset.to_string(),
    )?;
    let reproduce = Reproduce {
        build: res.builds.swap_remove(0),
        eval,
        jobset,
    };

    if to_json {
        println!("{}", serde_json::to_string(&reproduce).unwrap());
    } else {
        build_pretty_print(&reproduce.build);
        let input = &reproduce.eval.jobsetevalinputs[&reproduce.jobset.nixexprinput];
        if input.input_type == "git" {
            println!("{:14} {}", "Repository", input.uri.as_ref().unwrap());
            println!("{:14} {}", "Revision", input.revision.as_ref().unwrap());
        }
        println!("{:14} {}", "Attribute name", reproduce.build.job);
        println!("{:14} {}", "Nix expr path", reproduce.jobset.nixexprpath);

        println!("Inputs:");
        evaluation_pretty_print(&reproduce.eval);
        println!("{:14} {}/build/{}", "Hydra url", host, reproduce.build.id);
    }
    Ok(())
}
