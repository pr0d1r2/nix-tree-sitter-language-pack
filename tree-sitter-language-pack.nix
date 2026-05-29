{
  pkgs,
  version ? "1.8.1",
}:
let
  pythonPkgs = pkgs.python313Packages;

  wheelInfo =
    {
      "x86_64-linux" = {
        url = "https://files.pythonhosted.org/packages/b5/20/6f0c5b2b40de5a38134a1810b718775b960170b841bd079bd85d8e5b6616/tree_sitter_language_pack-1.8.1-cp310-abi3-manylinux_2_34_x86_64.whl";
        hash = "sha256:79c5a3ce9a912dfddd08147cc14c91f7baa152ca18d39591eb3db8471e42400d";
      };
      "aarch64-linux" = {
        url = "https://files.pythonhosted.org/packages/37/e4/732e445d4341e86473c082a9debbca7c46de17ac935284c7060202b068ba/tree_sitter_language_pack-1.8.1-cp310-abi3-manylinux_2_34_aarch64.whl";
        hash = "sha256:fa15da867ca257353fa4a709fb6c10f2fcc4b8c0899f27b883872c2feeaac61e";
      };
      "x86_64-darwin" = {
        url = "https://files.pythonhosted.org/packages/9f/9c/a9faacacdec92026b88bceeb08646be7c32edf05796e6f19d00873cdc1e4/tree_sitter_language_pack-1.8.1-cp310-abi3-macosx_10_12_x86_64.whl";
        hash = "sha256:b0e3cd56dc359dbd623cc90df09494be4de1605628e53f92b981cd78a7de1a81";
      };
      "aarch64-darwin" = {
        url = "https://files.pythonhosted.org/packages/7c/44/aded4a03575c8b010b03d574fadb5dc705a898a1d940670014634b1d819e/tree_sitter_language_pack-1.8.1-cp310-abi3-macosx_11_0_arm64.whl";
        hash = "sha256:a5c378bf1b920fa2470a668a7bf20b2e99a9288641bf6a04c5cfb8051fe91ea1";
      };
    }
    .${pkgs.stdenv.hostPlatform.system};
in
pythonPkgs.buildPythonPackage {
  pname = "tree-sitter-language-pack";
  inherit version;
  format = "wheel";

  src = pkgs.fetchurl {
    inherit (wheelInfo) url hash;
  };

  dependencies = with pythonPkgs; [
    tree-sitter
  ];

  pythonImportsCheck = [ "tree_sitter_language_pack" ];

  meta = with pkgs.lib; {
    description = "Pre-compiled tree-sitter grammars for 305 programming languages";
    homepage = "https://github.com/kreuzberg-dev/tree-sitter-language-pack";
    license = licenses.mit;
  };
}
