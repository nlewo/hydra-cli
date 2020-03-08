# hydra-cli

[![Build Status](https://travis-ci.com/nlewo/hydra-cli.svg?branch=master)](https://travis-ci.com/nlewo/hydra-cli)

`hydra-cli` lets you talk to the JSON API of [hydra](https://nixos.org/hydra) on the command line. It
includes commands for querying and creating projects and jobsets.

<p align="center">
    <img src="https://raw.githubusercontent.com/nlewo/hydra-cli/master/logo.png"
         title="hydra-cli logo from https://game-icons.net/1x1/lorc/hydra.html"
         width="128" height="128">
</p>

## Installation

Use `nix-env` to install: 

```
nix-env -f https://github.com/nlewo/hydra-cli/archive/master.tar.gz -iA hydra-cli
```

## Build

Inside the provided nix shell:

```bash
$ cargo build
```

## Usage

`hydra-cli` talks to the JSON API of hydra and allows you to query, create and wait for
projects and jobsets:

- [project-create](#project-create) Creates a project.
- [project-list](#project-list) Lists existing projects.
- [project-show](#project-show) Shows the projects' information.
- [jobset-create](#jobset-create) Creates a jobset in a project.
- [jobset-wait](#jobset-wait) Waits for a jobset's completion.
- [reproduce](#reproduce) Retrieves information for reproducing an output path.
- [search](#search) Searches for an output path.

By default `hydra-cli` talks to https://hydra.nixos.org. The default can be
overwritten by setting the `HYDRA_HOST` environment variable or by passing `--host <host>` on the
command line.

### Commands

`$ hydra-cli --help`
```
hydra-cli 0.2.0
lewo
CLI Hydra client

USAGE:
    hydra-cli [FLAGS] [OPTIONS] [SUBCOMMAND]

FLAGS:
    -h, --help                    Prints help information
        --no-check-certificate    Disable TLS certificate check for the Hydra host
    -V, --version                 Prints version information

OPTIONS:
    -H, --host <host>    Hydra host URL [env: HYDRA_HOST=]  [default: https://hydra.nixos.org]

SUBCOMMANDS:
    help              Prints this message or the help of the given subcommand(s)
    jobset-create     Add a jobset to a project
    jobset-eval       Evaluate a jobset
    jobset-wait       Wait for jobset completion
    project-create    Create a new project
    project-list      List projects
    project-show      Get information of a project
    reproduce         Retrieve information to reproduce an output path
    search            Search by output paths

A client to query Hydra through its JSON API.
```
#### project-create

The `project-create` command creates a new project under the name specified. The created project
will be _enabled_ and _visible_. _Note_: this command requires user authentication.

`$ hydra-cli project-create --help`
```
hydra-cli-project-create 
Create a new project

USAGE:
    hydra-cli project-create <project> --password <password> --user <user>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --password <password>    A user password [env: HYDRA_PASSWORD=]
        --user <user>            A user name [env: HYDRA_USER=]

ARGS:
    <project>    The name of the project in which to create the jobset
```
#### project-list

The `project-list` command retrieves a list of all configured projects.

`$ hydra-cli project-list --help`
```
hydra-cli-project-list 
List projects

USAGE:
    hydra-cli project-list [FLAGS]

FLAGS:
    -h, --help       Prints help information
    -j               JSON output
    -V, --version    Prints version information
```
#### project-show

The `project-show` command displays information on a given project.

`$ hydra-cli project-show --help`
```
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
```
#### jobset-create

The `jobset-create` command creates a new jobset and adds it to the project specified.

`$ hydra-cli jobset-create --help`
```
hydra-cli-jobset-create 
Add a jobset to a project

USAGE:
    hydra-cli jobset-create <project> <jobset> <config> --password <password> --user <user>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --password <password>    A user password [env: HYDRA_PASSWORD=]
        --user <user>            A user name [env: HYDRA_USER=]

ARGS:
    <project>    The project to add the jobset to
    <jobset>     The name of the jobset to create
    <config>     Project configuration JSON filepath

Here is an example JSON config:

{
  "description": "hydra-cli master jobset",
  "checkinterval": 60,
  "enabled": 1,
  "visible": true,
  "keepnr": 3,
  "nixexprinput": "src",
  "nixexprpath": "default.nix",
  "inputs": {
    "src": {
      "value": "https://github.com/nlewo/hydra-cli.git master",
      "type": "git",
      "revision": null,
      "uri": null
    }
  }
}
```
#### jobset-eval

The `jobset-eval` command starts the evaluation of a jobset.

`$ hydra-cli jobset-eval --help`
```
hydra-cli-jobset-eval 
Evaluate a jobset

USAGE:
    hydra-cli jobset-eval <project> <jobset>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

ARGS:
    <project>    The project to evaluate the jobset from
    <jobset>     The jobset to evaluate
```
#### jobset-wait

The `jobset-create` command waits until the specified jobset has been evaluated.

`$ hydra-cli jobset-wait --help`
```
hydra-cli-jobset-wait 
Wait for jobset completion

USAGE:
    hydra-cli jobset-wait [OPTIONS] <project> <jobset>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --timeout <timeout>    Maximum time to wait for (in seconds)

ARGS:
    <project>    The project of the jobset to wait for
    <jobset>     The name of the jobset to wait for
```
#### reproduce

The `reproduce` command retrieves information on how to reproduce a given output-path.

`$ hydra-cli reproduce --help`
```
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
```
#### search

The `search` command searches for a jobset based on the output-path specified.

`$ hydra-cli search --help`
```
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
```
### Contributing

Contributions to the project are welcome in the form of GitHub PRs. Please consider
the following guidelines before creating PRs:

- Please make sure to format your code using `rustfmt`
- If you are planning to make any considerable changes, you should first present your plans in a GitHub issue so it can be discussed.
- If you are adding features please consider the possibility of adding a test in [tests/vm.nix](./tests/vm.nix)

#### Updating the README

`hydra-cli` uses [mdsh](https://github.com/zimbatm/mdsh) to create and verify the README.md you are looking at. Changes to the `hydra-cli`
command syntax will failing tests on [hydra](https://hydra.nix.corp.cloudwatt.com/project/hydra-cli). 

You can execute the tests locally by running:

```
nix-build -A tests.readme
```

If you want to update the README.md after having made relevant changes to `hydra-cli` you can do so as follows:

```
cp $(nix-build -A readme) ./README.md
```


### License

- Licensed under [MIT](./LICENSE). 
- The `hydra-cli` logo has been created using [https://game-icons.net](https://game-icons.net/1x1/lorc/hydra.html).
