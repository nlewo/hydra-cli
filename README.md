# `hydra-cli`

## hydra-cli

    hydra-cli 0.1
    Antoine Eiche
    CLI Hydra client
    
    USAGE:
        hydra-cli [OPTIONS] [SUBCOMMAND]
    
    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information
    
    OPTIONS:
        -H <host>        Hydra host URL [default: https://hydra.nixos.org]
    
    SUBCOMMANDS:
        help         Prints this message or the help of the given subcommand(s)
        reproduce    Retrieve information to reproduce an output path
        search       Search by output paths
    
    A client to query Hydra through its JSON API.

## Command 

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

## Command 

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

