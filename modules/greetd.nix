{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.greetd = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          command = lib.mkOption { type = lib.types.str; };
          tty = lib.mkOption { type = lib.types.int; };
        };
      });
    };
  };

}
