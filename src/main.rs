extern crate hydra_cli;

use clap::{App, Arg, SubCommand};
use hydra_cli::ops::{create, project, reproduce, search};
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
        )
        .subcommand(
            SubCommand::with_name("create")
                .about("Create a new project")
                .arg(
                    Arg::with_name("config")
                        .takes_value(true)
                        .long("config")
                        .required(true)
                        .help("Project configuration in JSON"),
                )
                .arg(
                    Arg::with_name("jobset")
                        .required(true)
                        .help("The name of the jobset to create"),
                )
                .arg(
                    Arg::with_name("user")
                        .takes_value(true)
                        .required(true)
                        .long("user")
                        .env("HYDRA_USER")
                        .help("A user name"),
                )
                .arg(
                    Arg::with_name("password")
                        .takes_value(true)
                        .required(true)
                        .long("password")
                        .env("HYDRA_PW")
                        .help("A user password"),
                ),
        );

    let mut help_buffer = Vec::new();
    app.write_help(&mut help_buffer).unwrap();
    let help_string = String::from_utf8(help_buffer).unwrap();

    let matches = app.get_matches();
    let host = matches.value_of("host").unwrap();
    let _ = match matches.subcommand() {
        ("search", Some(args)) => search::run(
            host,
            args.value_of("QUERY").unwrap(),
            args.value_of("limit").unwrap().parse().unwrap(),
        ),

        ("reproduce", Some(args)) => reproduce::run(
            host,
            args.value_of("QUERY").unwrap(),
            args.is_present("json"),
        ),

        ("project", Some(args)) => project::run(
            host,
            args.value_of("PROJECT").unwrap(),
            args.is_present("json"),
        ),

        ("create", Some(args)) => create::run(
            host,
            args.value_of("config").unwrap(),
            args.value_of("jobset").unwrap(),
            args.value_of("user").unwrap(),
            args.value_of("password").unwrap(),
        ),

        _ => {
            println!("{}", help_string);
            Ok(())
        }
    };

    Ok(())
}
