{ pkgs, rust-gps,...}:
{    
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;

  networking.wireless.enable = true;  
  networking.wireless.networks = {
    trailer = {
      psk = "";
    };
  };

  users.users.lucas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout"]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
    password = "";
  };

  environment.systemPackages = [
    pkgs.helix
    pkgs.screen
    rust-gps.packages.riscv64-linux.default
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  
}
