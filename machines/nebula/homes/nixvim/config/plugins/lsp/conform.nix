{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notifyOnError = true;
      formattersByFt = {
        liquidsoap = [ "liquidsoap-prettier" ];
        html = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        css = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        python = [ "black" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        markdown = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        yaml = [
          "yamllint"
          "yamlfmt"
        ];
      };
    };
  };
}