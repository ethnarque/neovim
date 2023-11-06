final: prev: {
  vimPlugins =
    prev.vimPlugins
    // {
      mini-files-nvim = final.vimUtils.buildVimPlugin {
        pname = "mini.files";
        version = "0.10.0";
        src = final.fetchFromGitHub {
          owner = "echasnovski";
          repo = "mini.files";
          rev = "3f8af5f9e4bbedbacbade760531464c0d679490d";
          hash = "sha256-9Xob5PHO+J4VgE8zDMLiewNO70sXQRXBs2td26yfUZY=";
        };
        meta.homepage = " https://github.com/echasnovski/mini.files ";
      };
    };
}



