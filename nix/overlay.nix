inputs: final: prev: rec {

  lua-format = prev.pkgs.stdenv.mkDerivation {
    name = "lua-format";

    # src = inputs.lua-format;
    src = prev.pkgs.fetchgit {
      url = "https://github.com/Koihik/LuaFormatter.git";
      rev = "78b3d90ca49818bc72ef4ec39409924c33daa020";
      sha256 = "0snfh4h9s0xb2cayyqzjjqg4b0vq589ln2yb0ci5n2xm15dchycl";
      fetchSubmodules = true;
    };

    buildInputs = with prev.pkgs; [ unzip ];
    nativeBuildInputs = with prev.pkgs; [ cmake ];
  };

  efm-langserver = prev.pkgs.buildGoModule rec {
    name = "efm-langserver";

    src = inputs.efm-langserver;

    doCheck = false;

    vendorSha256 = "1whifjmdl72kkcb22h9b1zadsrc80prrjiyvyba2n5vb4kavximm";
  };
}
