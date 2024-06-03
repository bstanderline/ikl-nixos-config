{ lib, pkgs, ... }:
with lib;
with lib.ikl; {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "IKLAZV23";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=25%" "mode=755" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-label/nix";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-label/data";
      neededForBoot = true;
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = pkgs.lib.mkForce "uk";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  users.users.italik.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGZchNdZjwvX4Ie0ICn/+C9S11m71J0aCxOoD6gBXni RDM--IKLAZV23"
  ];


  ikl = {
    services = {
      sftpgo.enable = true;
    };
    system = {
      impermanence.enable = true;
      ssh.enable = true;
      users.enable = true;
    };
  };

  # Override SSH port as SFTPGo uses port 22
  services.openssh.ports = lib.mkForce [ 7356 ];
}