{ pkgs, hydra-cli }:

let
  testing = import (pkgs.path + /nixos/lib/testing.nix) { system = builtins.currentSystem; };
  makeTest = testing.makeTest;

  jobSuccess = pkgs.writeTextDir "job.nix" ''
   { success = builtins.derivation {
       name = "success";
       system = "x86_64-linux";
       builder = "/bin/sh";
       args = ["-c" "echo success > $out; exit 0"];
     };
   }
   '';

  jobFail = pkgs.writeTextDir "job.nix" ''
   { fail = builtins.derivation {
       name = "fail";
       system = "x86_64-linux";
       builder = "/bin/sh";
       args = ["-c" "sleep 5; echo fail > $out; exit 1"];
     };
   }
  '';

  mkJobset = description: path: pkgs.writeTextFile {
    name = "jobset.json";
    text = builtins.toJSON {
      inherit description;
      checkinterval = 60;
      enabled = 1;
      visible = true;
      keepnr = 1;
      nixexprinput = "expr";
      nixexprpath = "job.nix";
      inputs = {
        expr = {
          value = path;
          type = "path";
        };
      };
    };
  };

  jobsetSuccess = mkJobset "Success" jobSuccess;
  jobsetFail = mkJobset "Fail" jobFail;

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
        package = pkgs.hydra-unstable;
        #Hydra needs those settings to start up, so we add something not harmfull.
        hydraURL = "example.com";
        notificationSender = "example@example.com";
      };
      nix = {
        buildMachines = [{
          hostName = "localhost";
          systems = [ "x86_64-linux" ];
        }];

        binaryCaches = pkgs.lib.mkForce [];
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

    $machine->succeed("hydra-cli -H http://localhost:3000 jobset-create test success ${jobsetSuccess} --password admin --user admin ");
    $machine->succeed("hydra-cli -H http://localhost:3000 jobset-wait test success");
    $machine->succeed("hydra-cli -H http://localhost:3000 jobset-eval test success");

    $machine->succeed("hydra-cli -H http://localhost:3000 jobset-create test fail ${jobsetFail} --password admin --user admin");
    $machine->fail("hydra-cli -H http://localhost:3000 jobset-wait test fail");
    $machine->succeed("hydra-cli -H http://localhost:3000 jobset-eval test fail");
  '';
}
