{ pkgs, ... }:
{
  home.file.".config/VSCodium/product.json".text = ''
    {
      "extensionsGallery": {
        "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
        "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
        "itemUrl": "https://marketplace.visualstudio.com/items",
        "controlUrl": "",
        "recommendationsUrl": ""
      },
      "extensionAllowedProposedApi": [
        "ms-toolsai.jupyter"
      ]
    }
  '';

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = (
      with pkgs.vscode-extensions; [
        coenraads.bracket-pair-colorizer-2
        eamodio.gitlens
        jnoortheen.nix-ide
        redhat.vscode-yaml
        shardulm94.trailing-spaces
      ]
    ) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-icons";
        publisher = "vscode-icons-team";
        version = "11.4.0";
        sha256 = "0zdyn554gl9cpbw0rfmj96yzdmpy3942kxp377m6qkiavyi0d6s9";
      }
      {
        name = "path-autocomplete";
        publisher = "ionutvmi";
        version = "1.17.1";
        sha256 = "0nlyvlwp0s8cf3ky33i11dfc8rhc90lmwq0z5km4yxvbs9zya6a3";
      }
      {
        name = "vscode-firefox-debug";
        publisher = "firefox-devtools";
        version = "2.9.4";
        sha256 = "00fz7i83nskqpvr3a0x0zzb1fw5phbg7llss7b6633w0m94sc85k";
      }
    ];
    userSettings = {
      "editor.formatOnPaste" = true;
      "editor.formatOnType" = true;
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "all";
      "editor.rulers" = [ 120 ];
      "editor.tabSize" = 2;
      "extensions.autoUpdate" = false;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "search.collapseResults" = "auto";
      "terminal.integrated.copyOnSelection" = true;
      "update.mode" = "none";
      "workbench.colorTheme" = "Monokai";
      "workbench.commandPalette.preserveInput" = true;
      "workbench.editor.enablePreviewFromCodeNavigation" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";
    };
  };
}
