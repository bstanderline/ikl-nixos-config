{ lib, pkgs, ... }:
with lib;
with lib.ikl; {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "IKLAZV23";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

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

  ikl = {
    services = {
      sftpgo.enable = true;
    };
  };
}