final: prev: {
  rustywind = final.rustPlatform.buildRustPackage rec {
    pname = "rustywind";
    version = "v0.16.0";

    src = final.fetchFromGitHub {
      owner = "avencera";
      repo = pname;
      rev = version;
      sha256 = "xDpRS8WrFu5uPtbXJGXrxElJinxl1lkpYZ1tGrNrBHA=";
    };

    cargoSha256 = "r9ukb4ZyXbMWFNlrikQE/ELSvDL164W2kwjyxZYbwZA=";
  };
}
