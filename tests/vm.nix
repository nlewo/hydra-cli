{ pkgs, hydra-cli }:

let
  testing = import (pkgs.path + /nixos/lib/testing.nix) { system = builtins.currentSystem; };
  makeTest = testing.makeTest;
in
makeTest {
  name = "hydra";
  machine = { pkgs, ... }:
    {
      virtualisation.memorySize = 1024;
      time.timeZone = "UTC";
      networking.firewall.allowedTCPPorts = [ 3000 ];
      environment.systemPackages = [ hydra-cli ];
      services.hydra = {
        enable = true;
        #Hydra needs those settings to start up, so we add something not harmfull.
        hydraURL = "example.com";
        notificationSender = "example@example.com";
      };
      nix = {
        buildMachines = [{
          hostName = "localhost";
          systems = [ "x86_64-linux" ];
        }];

        binaryCaches = [];
      };
    };
  testScript = ''
    # let the system boot up
    $machine->waitForUnit("multi-user.target");
    # test whether the database is running
    $machine->succeed("systemctl status postgresql.service");
    # test whether the actual hydra daemons are running
    $machine->succeed("systemctl status hydra-queue-runner.service");
    $machine->succeed("systemctl status hydra-init.service");
    $machine->succeed("systemctl status hydra-evaluator.service");
    $machine->succeed("systemctl status hydra-send-stats.service");

    $machine->succeed("hydra-create-user admin --role admin --password admin");

    # create a project with a trivial job
    $machine->waitForOpenPort(3000);

    $machine->succeed("hydra-cli -H http://localhost:3000 project-create test --password admin --user admin");
    $machine->succeed("hydra-cli -H http://localhost:3000 project-list | grep -q test");
  '';
}
