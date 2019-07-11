# `hydra-cli`

**Warning: This project is WIP and only the latest Hydra revision is supported.**

## Install

    nix-env -f https://github.com/nlewo/hydra-cli/archive/master.tar.gz -iA hydra-cli


## Usage `hydra-cli`

    hydra-cli 0.1
    lewo
    CLI Hydra client
    
    USAGE:
        hydra-cli [OPTIONS] [SUBCOMMAND]
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    OPTIONS:
        -H <host>        Hydra host URL [env: HYDRA_HOST=]  [default: https://hydra.nixos.org]
    
    SUBCOMMANDS:
        create-project    Create a new project
        help              Prints this message or the help of the given subcommand(s)
        reproduce         Retrieve information to reproduce an output path
        search            Search by output paths
        show-project      Get information of a project
    
    A client to query Hydra through its JSON API.

### Command `hydra-cli create-project`

    hydra-cli-create-project 
    Create a new project
    
    USAGE:
        hydra-cli create-project <jobset> --config <config> --password <password> --project <project> --user <user>
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    OPTIONS:
            --config <config>        Project configuration in JSON
            --password <password>    A user password [env: HYDRA_PW=]
            --project <project>      The name of the project in which to create the jobset
            --user <user>            A user name [env: HYDRA_USER=]
    
    ARGS:
        <jobset>    The name of the jobset to create

### Command `hydra-cli reproduce`

    hydra-cli-reproduce 
    Retrieve information to reproduce an output path
    
    USAGE:
        hydra-cli reproduce [FLAGS] <QUERY>
    
    FLAGS:
        -h, --help       Prints help information
        -j               JSON output
        -V, --version    Prints version information
    
    ARGS:
        <QUERY>    Piece of an output path (hash, name,...)

### Command `hydra-cli search`

    hydra-cli-search 
    Search by output paths
    
    USAGE:
        hydra-cli search <QUERY> [limit]
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    ARGS:
        <QUERY>    Piece of an output path (hash, name,...)
        <limit>    How many results to return [default: 10]

### Command `hydra-cli show-project`

    hydra-cli-show-project 
    Get information of a project
    
    USAGE:
        hydra-cli show-project [FLAGS] <PROJECT>
    
    FLAGS:
        -h, --help       Prints help information
        -j               JSON output
        -V, --version    Prints version information
    
    ARGS:
        <PROJECT>    A project name

