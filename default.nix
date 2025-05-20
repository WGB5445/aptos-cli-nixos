let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation rec{
  pname = "aptos";
  version = "7.3.0";

  src = pkgs.fetchzip {
    url = "https://github.com/aptos-labs/aptos-core/releases/download/aptos-cli-v${version}/aptos-cli-${version}-Linux-x86_64.zip";
    sha256 = "sha256-3xuxpGTua1J8mUwG6AIeiCjlfL9bUawBm7nMagnJYHI=";
  };

  nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.unzip ];
  buildInputs = [
    pkgs.stdenv.cc.cc.lib
    pkgs.gcc
    pkgs.openssl_3
    pkgs.systemd
  ];
  dontConfigure = true;
  dontBuild = true;

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    cp ${src}/aptos $out/bin/
    chmod +x $out/bin/aptos
  '';
  meta = with pkgs.lib; {
    description = "Command-line interface for interacting with the Aptos blockchain";
    homepage    = "https://github.com/aptos-labs/aptos-core";
    license     = licenses.asl20;
    maintainers = [{
   	name  = "WGB5445";
    	email = "wgb98512@gmail.com";
    	github = "WGB5445"; 
    } ];
    platforms   = [ "x86_64-linux" ];
  };
}
