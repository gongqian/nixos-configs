{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkIf optionalAttrs;
in {
  config = mkIf config.boot.loader.systemd-boot.enable {
    boot.loader = {
      systemd-boot = {
        configurationLimit = null; # unlimited
        consoleMode = mkDefault "max"; # the default is "keep", can be overriden per host if need be

        # Fix a security hole in place for backwards compatibility. See desc in
        # nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
        editor = false;
      };
    };
  };
}
