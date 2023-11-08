{ pkgs }: pkgs.vimUtils.buildVimPlugin {
  pname = "mini.pairs";
  version = "0.10.0";
  src = pkgs.fetchFromGitHub {
    owner = "echasnovski";
    repo = "mini.pairs";
    rev = "71f117fd57f930da6ef4126b24f594dd398bac26";
    hash = "sha256-zhvZALE0vXzdzUmksmcpcGMVeexdbdx8HD/EIamtDZg=";
  };
  meta.homepage = " https://github.com/echasnovski/mini.pairs ";
}
