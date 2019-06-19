extern crate clap; 
extern crate serde_derive;
extern crate reqwest;
use reqwest::Error;
use serde_json::{Value};
use clap::{Arg, App, SubCommand};
use std::collections::{HashMap};
use serde::{Deserialize, Serialize};
extern crate chrono;
use chrono::{NaiveDateTime};
#[macro_use]
extern crate log;
use serde::de::DeserializeOwned;

#[cfg(test)]
use std::fs::File;
#[cfg(test)]
use std::io::prelude::*;

#[test]
// This is useful for developping purpose (this is not a test yet).
fn builds() -> Result<(), std::io::Error>{
    let mut file = File::open("data/search-build.json")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let s: Search = serde_json::from_str(&contents)?;

    for b in s.builds {
        build_pretty_print(&b);
        println!("");
    }
    Ok(())
}

#[test]
// This is useful for developping purpose (this is not a test yet).
fn test_eval() -> Result<(), std::io::Error>{
    let mut file = File::open("data/eval-1525352.json")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let e: Eval = serde_json::from_str(&contents)?;
    evaluation_pretty_print(&e);
    Ok(())
}

#[derive(Serialize, Deserialize, Debug)]
struct Input {
    value: Option<String>,
    #[serde(rename = "type")]
    input_type: String,
    revision: Option<String>,
    uri:Option<String>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Eval {
    jobsetevalinputs: HashMap<String, Input>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Jobset {
    nixexprpath: String,
    nixexprinput: String,
}

#[derive(Serialize, Deserialize, Debug, Clone)]
struct Path {
    path: String
}

#[derive(Serialize, Deserialize, Debug, Clone)]
struct Build {
    id: i64,
    project: String,
    drvpath: String,
    job: String,
    jobset:String,
    buildoutputs: HashMap<String, Path>,
    stoptime: i64,
    jobsetevals: Vec<i64>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Search {
    builds: Vec<Build>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Reproduce {
    build: Build,
    eval: Eval,
    jobset: Jobset,
}

fn build_pretty_print(b: &Build) {
    println!("{:14} {}/{}/{}", "Job", b.project, b.jobset, b.job);
    println!("{:14} {}", "Finished at",
             NaiveDateTime::from_timestamp(b.stoptime, 0),
    );
    println!("{:14} {}", "Derviation", b.drvpath);
    println!("{:14}", "Build outputs");
    for (k, v) in &b.buildoutputs {
        println!("  {:12} {}", k, v.path);
    }
}

fn evaluation_pretty_print(e: &Eval) {
    for (k, v) in &e.jobsetevalinputs {
        println!("  {}", k);
        println!("    {:10} {}", "type", v.input_type);
        if let Some(t) = &v.value {
            println!("    {:10} {}", "value", t);
        }
        if let Some(t) = &v.uri {
            println!("    {:10} {}", "uri", t);
        }
        if let Some(t) = &v.revision {
            println!("    {:10} {}", "revision", t);
        }
    }
}

fn query<T: DeserializeOwned>(request_url: String) -> Result<T, Error> {
    debug!("Request url: {}", request_url);
    let client = reqwest::Client::new();
    let mut res = client
        .get(&request_url)
        .header(reqwest::header::CONTENT_TYPE, "application/json")
        .send()?;
    
    let v: Value = res.json()?;
    let res = serde_json::from_value(v).unwrap();
    Ok(res)
}

fn eval(host: String, number: i64) -> Result<Eval, Error> {
    let request_url = format!("{host}/eval/{number}",
                              host = host,
                              number = number);
    let res: Eval = query(request_url)?;
    Ok(res)
}

fn jobset(host: String, project: String, jobset: String) -> Result<Jobset, Error> {
    let request_url = format!("{host}/jobset/{project}/{jobset}",
                              host = host,
                              project = project,
                              jobset = jobset);
    let res: Jobset = query(request_url)?;
    Ok(res)
}

fn search(host: String, queri: String, limit: usize) -> Result<Search, Error> {
    let request_url = format!("{host}/search?query={query}",
                              host = host,
                              query = queri);
    let mut search: Search = query(request_url)?;
    // TODO: implement limit in Hydra API
    if search.builds.len() > limit {
        search.builds = search.builds[0..limit].to_vec();
    }
    debug!("{:?}", search);
    Ok(search)
}

fn main() -> Result<(), Error> { 
    let matches = App::new("hydra-cli")
        .version("0.1")
        .about("CLI Hydra client")
        .author("lewo")
        .after_help("A client to query Hydra through its JSON API.")
        .arg(Arg::with_name("host")
             .short("H")
             .default_value("https://hydra.nixos.org")
             .env("HYDRA_HOST")
             .help("Hydra host URL"))
        .subcommand(SubCommand::with_name("search")
                    .about("Search by output paths")
                    .arg(Arg::with_name("QUERY")
                         .required(true)
                         .help("Piece of an output path (hash, name,...)"))
                    .arg(Arg::with_name("limit")
                         .default_value("10")
                         .help("How many results to return")))
        .subcommand(SubCommand::with_name("reproduce")
                    .about("Retrieve information to reproduce an output path")
                    .arg(Arg::with_name("QUERY")
                         .required(true)
                         .help("Piece of an output path (hash, name,...)"))
                    .arg(Arg::with_name("json")
                         .short("j")
                         .help("JSON output")))
        .get_matches();
    
    let host = matches.value_of("host").unwrap();
    debug!("Host: {}", host);

    if let Some(matches) = matches.subcommand_matches("search") {
        let limit = matches.value_of("limit").unwrap().parse().unwrap();
        let search = search(host.to_string(),
                            matches.value_of("QUERY").unwrap().to_string(),
                            limit)?;
        for b in search.builds {
            build_pretty_print(&b);
            println!();
        }
    }
    else if let Some(matches) = matches.subcommand_matches("reproduce") {
        let mut search = search(host.to_string(), matches.value_of("QUERY").unwrap().to_string(), 1)?;
        if search.builds.len() == 0 {
            println!("No builds found. Exiting.");
            return Ok(())
        }
        else if search.builds.len() > 1 {
            eprintln!("Warning: the query matches {} builds, considering the first one.", search.builds.len());
        }
        let eval = eval(host.to_string(),
                        search.builds[0].jobsetevals[0])?;
        let jobset = jobset( host.to_string(),
                             search.builds[0].project.to_string(),
                             search.builds[0].jobset.to_string())?;
        let reproduce = Reproduce {
            build: search.builds.swap_remove(0),
            eval: eval,
            jobset: jobset,
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
    }
    Ok(())
}
