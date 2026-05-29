{
  pkgs,
  version ? "1.6.2",
}:
let
  pythonPkgs = pkgs.python313Packages;

  wheelInfo =
    {
      "x86_64-linux" = {
        url = "https://files.pythonhosted.org/packages/fa/a4/629e6983a93fbb52dc50af495ec0431565c6477eea4680d4298238e9831e/tree_sitter_language_pack-1.6.2-cp310-abi3-manylinux_2_34_x86_64.whl";
        hash = "sha256:2305df7835c1cb3d34b71450b79d135878bc25ea5d02d9984cee864607a4ad60";
      };
      "aarch64-linux" = {
        url = "https://files.pythonhosted.org/packages/a1/e0/b997b8c3e0886288a47890e6313c3a7e74ea8192e2d141b3eab64d59a276/tree_sitter_language_pack-1.6.2-cp310-abi3-manylinux_2_34_aarch64.whl";
        hash = "sha256:8ce814ede4e295f3419ba179b523889c52cc3a998ac085356a470e776596c026";
      };
      "aarch64-darwin" = {
        url = "https://files.pythonhosted.org/packages/09/bd/ac34ab0ee92b2d27802754c575965e921490ce11b5357bf89f74a78e8309/tree_sitter_language_pack-1.6.2-cp310-abi3-macosx_11_0_arm64.whl";
        hash = "sha256:f5998cfee5735a8e7e691f577062ff7eb3a7ea405ae5654c9cecaa4a1e6c81b0";
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
