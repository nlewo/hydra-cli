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
        help              Prints this message or the help of the given subcommand(s)
        jobset-create     Add jobsets to a project
        jobset-wait       Wait for jobset completion
        project-create    Create a new project
        project-list      List projects
        project-show      Get information of a project
        reproduce         Retrieve information to reproduce an output path
        search            Search by output paths
    
    A client to query Hydra through its JSON API.

### Command `hydra-cli jobset-create`

    hydra-cli-jobset-create 
    Add jobsets to a project
    
    USAGE:
        hydra-cli jobset-create <jobset> --config <config> --password <password> --project <project> --user <user>
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    OPTIONS:
            --config <config>        Project configuration in JSON
            --password <password>    A user password [env: HYDRA_PW=]
            --project <project>      The project to add the jobset to
            --user <user>            A user name [env: HYDRA_USER=]
    
    ARGS:
        <jobset>    The name of the jobset to create

### Command `hydra-cli jobset-wait`

    hydra-cli-jobset-wait 
    Wait for jobset completion
    
    USAGE:
        hydra-cli jobset-wait <project> <jobset>
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    ARGS:
        <project>    The project of the jobset to wait for
        <jobset>     The name of the jobset to wait for

### Command `hydra-cli project-create`

    hydra-cli-project-create 
    Create a new project
    
    USAGE:
        hydra-cli project-create <project> --password <password> --user <user>
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    OPTIONS:
            --password <password>    A user password [env: HYDRA_PW=]
            --user <user>            A user name [env: HYDRA_USER=]
    
    ARGS:
        <project>    The name of the project in which to create the jobset

### Command `hydra-cli project-list`

    hydra-cli-project-list 
    List projects
    
    USAGE:
        hydra-cli project-list [FLAGS]
    
    FLAGS:
        -h, --help       Prints help information
        -j               JSON output
        -V, --version    Prints version information

### Command `hydra-cli project-show`

    hydra-cli-project-show 
    Get information of a project
    
    USAGE:
        hydra-cli project-show [FLAGS] <project>
    
    FLAGS:
        -h, --help       Prints help information
        -j               JSON output
        -V, --version    Prints version information
    
    ARGS:
        <project>    A project name

### Command `hydra-cli reproduce`

    hydra-cli-reproduce 
    Retrieve information to reproduce an output path
    
    USAGE:
        hydra-cli reproduce [FLAGS] <query>
    
    FLAGS:
        -h, --help       Prints help information
        -j               JSON output
        -V, --version    Prints version information
    
    ARGS:
        <query>    Piece of an output path (hash, name,...)

### Command `hydra-cli search`

    hydra-cli-search 
    Search by output paths
    
    USAGE:
        hydra-cli search <query> [limit]
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    ARGS:
        <query>    Piece of an output path (hash, name,...)
        <limit>    How many results to return [default: 10]

