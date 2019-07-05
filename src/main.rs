extern crate hydra_cli;

use clap::{App, Arg, SubCommand};
use hydra_cli::ops::{project, reproduce, search};
use reqwest::Error;

fn main() -> Result<(), Error> {
    let app = App::new("hydra-cli")
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
        );

    let matches = app.get_matches();
    let host = matches.value_of("host").unwrap();
    let _ = match matches.subcommand() {
        ("search", Some(args)) => search::run(
            host,
            args.value_of("QUERY").unwrap(),
            args.value_of("limit").unwrap().parse().unwrap(),
        ),

        ("reproducible", Some(args)) => reproduce::run(host, args.value_of("QUERY").unwrap()),

        ("project", Some(args)) => project::run(
            host,
            args.value_of("PROJECT").unwrap(),
            matches.is_present("json"),
        ),

        _ => Ok(()),
    };

    Ok(())
}
