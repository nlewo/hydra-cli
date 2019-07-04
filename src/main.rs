extern crate hydra_cli;

use hydra_cli::hydra::Reproduce;
use hydra_cli::pretty::{build_pretty_print, evaluation_pretty_print};
use hydra_cli::query::{eval, jobset, jobsetOverview, search};

extern crate clap;
extern crate reqwest;

use clap::{App, Arg, SubCommand};
use reqwest::Error;
#[macro_use]
extern crate log;

#[macro_use]
extern crate prettytable;
use prettytable::format;
use serde_json::Value;

#[cfg(test)]
use std::fs::File;
#[cfg(test)]
use std::io::prelude::*;

#[test]
// This is useful for developping purpose (this is not a test yet).
fn builds() -> Result<(), std::io::Error> {
    let mut file = File::open("data/search-build.json")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let s: Search = serde_json::from_str(&contents)?;

    for b in s.builds {
        build_pretty_print(&b);
        println!();
    }
    Ok(())
}

#[test]
// This is useful for developping purpose (this is not a test yet).
fn test_eval() -> Result<(), std::io::Error> {
    let mut file = File::open("data/eval-1525352.json")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let e: Eval = serde_json::from_str(&contents)?;
    evaluation_pretty_print(&e);
    Ok(())
}

fn main() -> Result<(), Error> {
    let matches = App::new("hydra-cli")
        .version("0.1")
        .about("CLI Hydra client")
        .author("lewo")
        .after_help("A client to query Hydra through its JSON API.")
        .arg(
            Arg::with_name("host")
                .short("H")
                .default_value("https://hydra.nixos.org")
                .env("HYDRA_HOST")
                .help("Hydra host URL"),
        )
        .subcommand(
            SubCommand::with_name("search")
                .about("Search by output paths")
                .arg(
                    Arg::with_name("QUERY")
                        .required(true)
                        .help("Piece of an output path (hash, name,...)"),
                )
                .arg(
                    Arg::with_name("limit")
                        .default_value("10")
                        .help("How many results to return"),
                ),
        )
        .subcommand(
            SubCommand::with_name("reproduce")
                .about("Retrieve information to reproduce an output path")
                .arg(
                    Arg::with_name("QUERY")
                        .required(true)
                        .help("Piece of an output path (hash, name,...)"),
                )
                .arg(Arg::with_name("json").short("j").help("JSON output")),
        )
        .subcommand(
            SubCommand::with_name("project")
                .about("Get information of a project")
                .arg(
                    Arg::with_name("PROJECT")
                        .required(true)
                        .help("A project name"),
                )
                .arg(Arg::with_name("json").short("j").help("JSON output")),
        )
        .get_matches();

    let host = matches.value_of("host").unwrap();
    debug!("Host: {}", host);

    if let Some(matches) = matches.subcommand_matches("search") {
        let limit = matches.value_of("limit").unwrap().parse().unwrap();
        let search = search(
            host.to_string(),
            matches.value_of("QUERY").unwrap().to_string(),
            limit,
        )?;
        for b in search.builds {
            build_pretty_print(&b);
            println!();
        }
    } else if let Some(matches) = matches.subcommand_matches("reproduce") {
        let mut search = search(
            host.to_string(),
            matches.value_of("QUERY").unwrap().to_string(),
            1,
        )?;
        if search.builds.is_empty() {
            println!("No builds found. Exiting.");
            return Ok(());
        } else if search.builds.len() > 1 {
            eprintln!(
                "Warning: the query matches {} builds, considering the first one.",
                search.builds.len()
            );
        }
        let eval = eval(host.to_string(), search.builds[0].jobsetevals[0])?;
        let jobset = jobset(
            host.to_string(),
            search.builds[0].project.to_string(),
            search.builds[0].jobset.to_string(),
        )?;
        let reproduce = Reproduce {
            build: search.builds.swap_remove(0),
            eval,
            jobset,
        };

        if matches.is_present("json") {
            let res = serde_json::to_string(&reproduce).unwrap();
            println!("{}", res);
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
    } else if let Some(matches) = matches.subcommand_matches("project") {
        let project = jobsetOverview(
            host.to_string(),
            matches.value_of("PROJECT").unwrap().to_string(),
        )?;
        if matches.is_present("json") {
            let res = serde_json::to_string(&project).unwrap();
            println!("{}", res);
        } else {
            let mut table = table!(["Jobset", "Succeeded", "Scheduled", "Failed"]);
            table.set_format(*format::consts::FORMAT_CLEAN);
            for j in project {
                let mut nrfailed = j.nrfailed.to_string();
                let mut nrscheduled = j.nrscheduled.to_string();
                let name = j.name;
                if j.nrfailed == 0 {
                    nrfailed = "".to_string();
                }
                if j.nrscheduled == 0 {
                    nrscheduled = "".to_string();
                }
                table.add_row(row![name, j.nrsucceeded, nrscheduled, nrfailed]);
            }
            table.printstd();
        }
    }
    Ok(())
}
