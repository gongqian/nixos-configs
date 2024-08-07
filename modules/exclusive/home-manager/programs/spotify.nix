{
  osConfig,
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  sys = modules.home;
  prg = sys.programs;

  spicePkgs = inputs.spicetify.packages.${pkgs.stdenv.system}.default;
in {
  imports = [inputs.spicetify.homeManagerModule];
  config = mkIf prg.spotify.enable {
    programs.spicetify = {
      spotifyPackage = pkgs.spotify;
      enable = true;
      # injectCss = true;
      # replaceColors = true;

      # overwriteAssets = true;
      # sidebarConfig = true;
      enabledCustomApps = with spicePkgs.apps; [
        lyrics-plus
        new-releases
      ];

      # theme = spicePkgs.themes.catppuccin;
      # colorScheme = "mocha";

      # custom Dribbblish theme
      theme = {
        name = "Dribbblish";
        src = officialThemesOLD;
        requiredExtensions = [
          # define extensions that will be installed with this theme
          {
            # extension is "${src}/Dribbblish/dribbblish.js"
            filename = "dribbblish.js";
            src = "${officialThemesOLD}/Dribbblish";
          }
        ];
        appendName = true; # theme is located at "${src}/Dribbblish" not just "${src}"

        # changes to make to config-xpui.ini for this theme:
        patches = {
          "xpui.js_find_8008" = ",(\\w+=)32,";
          "xpui.js_repl_8008" = ",$\{1}56,";
        };
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
        sidebarConfig = true;
      };

      # specify that we want to use our custom colorscheme
      colorScheme = "custom";

      # color definition for custom color scheme. (rosepine)
      customColorScheme = {
        text = "ebbcba";
        subtext = "F0F0F0";
        sidebar-text = "e0def4";
        main = "191724";
        sidebar = "2a2837";
        player = "191724";
        card = "191724";
        shadow = "1f1d2e";
        selected-row = "797979";
        button = "31748f";
        button-active = "31748f";
        button-disabled = "555169";
        tab-active = "ebbcba";
        notification = "1db954";
        notification-error = "eb6f92";
        misc = "6e6a86";
      };

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        playlistIcons
        lastfm
        genre
        historyShortcut
        bookmark
        fullAlbumDate
        groupSession
        popupLyrics
      ];
    };
  };
}
