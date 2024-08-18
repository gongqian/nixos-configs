#
# GTK 2/3/4 configurations
#
# This is fully dynamic custom gtk theme configuration. It is using adw-gtk3-dark as
# the base theme and overrides it with the my own custom colors.
#
{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  colors = import ./theme.nix {
    inherit osConfig pkgs;
  };
in {
  config = {
    xdg.systemDirs.data = let
      schema = pkgs.gsettings-desktop-schemas;
    in ["${schema}/share/gsettings-schemas/${schema.name}"];

    home = {
      packages = with pkgs; [
        glib # gsettings
      ];

      sessionVariables = {
        # set GTK theme to the name specified by the gtk theme package
        GTK_THEME = "adw-gtk3-dark"; # "Catppuccin-Mocha-Standard-Blue-dark";

        # gtk applications should use filepickers specified by xdg
        GTK_USE_PORTAL = "1";
      };
    };

    # Setup the base theme
    home.file.".local/share/themes/adw-gtk3-dark" = {
      source = ./adw-gtk3-dark;
      recursive = true;
    };

    gtk = {
      enable = true;
      theme = {
        # I use adw-gtk3-dark as the base theme and override it with my own
        # gtk color scheme
        name = "adw-gtk3-dark";
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "blue"; # "mauve";
          flavor = "mocha";
        };
      };

      font = {
        name = "Lexend";
        size = 14;
      };

      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        # gtk-application-prefer-dark-theme = true;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-decoration-layout = "appmenu:none";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-error-bell = 0;
      };

      gtk4.extraConfig = {
        # gtk-application-prefer-dark-theme = true;
        gtk-decoration-layout = "appmenu:none";
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-error-bell = 0;
      };
    };

    # This will override the base theme with the colorscheme
    # defined in gtk.css
    xdg.configFile = let
      gtkColors = builtins.readFile colors;
    in {
      "gtk-3.0/gtk.css".text = gtkColors;
      "gtk-4.0/gtk.css".text = gtkColors;
    };
  };
}
