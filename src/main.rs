extern crate hydra_cli;

use clap::{App, Arg, SubCommand};
use hydra_cli::hydra::reqwest_client::Client as ReqwestHydraClient;
use hydra_cli::ops::{
    jobset_create, jobset_wait, project, project_create, project_list, reproduce, search, OpError,
    OpResult,
};

fn main() {
    let app = App::new("hydra-cli")
        .version("0.2.0")
        .about("CLI Hydra client")
        .author("lewo")
        .after_help("A client to query Hydra through its JSON API.")
        .arg(
            Arg::with_name("host")
                .short("H")
                .long("host")
                .default_value("https://hydra.nixos.org")
                .env("HYDRA_HOST")
                .help("Hydra host URL"),
        )
        .arg(
            Arg::with_name("no-check-certificate")
                .long("no-check-certificate")
                .help("Disable TLS certificate check for the Hydra host"),
        )
        .subcommand(
            SubCommand::with_name("search")
                .about("Search by output paths")
                .arg(
                    Arg::with_name("query")
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
                    Arg::with_name("query")
                        .required(true)
                        .help("Piece of an output path (hash, name,...)"),
                )
                .arg(Arg::with_name("json").short("j").help("JSON output")),
        )
        .subcommand(
            SubCommand::with_name("project-list")
                .about("List projects")
                .arg(Arg::with_name("json").short("j").help("JSON output")),
        )
        .subcommand(
            SubCommand::with_name("project-show")
                .about("Get information of a project")
                .arg(
                    Arg::with_name("project")
                        .required(true)
                        .help("A project name"),
                )
                .arg(Arg::with_name("json").short("j").help("JSON output")),
        )
        .subcommand(
            SubCommand::with_name("project-create")
                .about("Create a new project")
                .arg(
                    Arg::with_name("project")
                        .required(true)
                        .help("The name of the project in which to create the jobset"),
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
                        .env("HYDRA_PASSWORD")
                        .help("A user password"),
                ),
        )
        .subcommand(
            SubCommand::with_name("jobset-create")
                .about("Add a jobset to a project")
                .arg(
                    Arg::with_name("project")
                        .required(true)
                        .help("The project to add the jobset to"),
                )
                .arg(
                    Arg::with_name("jobset")
                        .required(true)
                        .help("The name of the jobset to create"),
                )
                .arg(
                    Arg::with_name("config")
                        .required(true)
                        .help("Project configuration JSON filepath"),
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
                        .env("HYDRA_PASSWORD")
                        .help("A user password"),
                ),
        )
        .subcommand(
            SubCommand::with_name("jobset-wait")
                .about("Wait for jobset completion")
                .arg(
                    Arg::with_name("project")
                        .required(true)
                        .help("The project of the jobset to wait for"),
                )
                .arg(
                    Arg::with_name("jobset")
                        .required(true)
                        .help("The name of the jobset to wait for"),
                ),
        );

    let mut help_buffer = Vec::new();
    app.write_help(&mut help_buffer).unwrap();
    let help_string = String::from_utf8(help_buffer).unwrap();

    let matches = app.get_matches();
    let host = matches.value_of("host").unwrap();
    let no_check_certs = matches.is_present("no-check-certificate");
    let c = reqwest::Client::builder()
        .cookie_store(true)
        .danger_accept_invalid_certs(no_check_certs)
        .build()
        .unwrap();
    let client = ReqwestHydraClient::new(c, String::from(host));

    let cmd_res: OpResult = match matches.subcommand() {
        ("search", Some(args)) => search::run(
            &client,
            args.value_of("query").unwrap(),
            args.value_of("limit").unwrap().parse().unwrap(),
        ),

        ("reproduce", Some(args)) => reproduce::run(
            &client,
            host,
            args.value_of("query").unwrap(),
            args.is_present("json"),
        ),

        ("project-list", Some(args)) => project_list::run(&client, args.is_present("json")),

        ("project-show", Some(args)) => project::run(
            &client,
            args.value_of("project").unwrap(),
            args.is_present("json"),
        ),

        ("project-create", Some(args)) => project_create::run(
            &client,
            args.value_of("project").unwrap(),
            args.value_of("user").unwrap(),
            args.value_of("password").unwrap(),
        ),

        ("jobset-create", Some(args)) => jobset_create::run(
            &client,
            args.value_of("config").unwrap(),
            args.value_of("project").unwrap(),
            args.value_of("jobset").unwrap(),
            args.value_of("user").unwrap(),
            args.value_of("password").unwrap(),
        ),

        ("jobset-wait", Some(args)) => jobset_wait::run(
            &client,
            args.value_of("project").unwrap(),
            args.value_of("jobset").unwrap(),
        ),

        _ => {
            println!("{}", help_string);
            Err(OpError::CmdErr)
        }
    };

    match cmd_res {
        Ok(_) => std::process::exit(0),
        Err(OpError::AuthError) => {
            eprintln!("ERROR: Failed to login. Please check your credentials");
            std::process::exit(1)
        }
        Err(OpError::CmdErr) => {
            eprintln!("ERROR: hydra-cli called with invalid arguments");
            std::process::exit(1)
        }
        Err(OpError::RequestError(m)) => {
            eprintln!("ERROR: {}", m);
            std::process::exit(1)
        }
        Err(OpError::Error(m)) => {
            eprintln!("ERROR: {}", m);
            std::process::exit(1)
        }
    }
}
