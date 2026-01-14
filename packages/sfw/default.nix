{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  makeWrapper,
}:
buildNpmPackage {
  pname = "sfw";
  version = "2.0.4";

  src = fetchFromGitHub {
    owner = "SocketDev";
    repo = "sfw-installer";
    rev = "v2.0.4";
    hash = "sha256-fKnBwbddc62bMz8tT9sQaiG5ZLfh23F21+68U9SeAcc=";
  };

  npmDepsHash = "sha256-DxX4HofpZ0KnoV4xx9hwvQ5+YhDkiMFE2/y7ZPVF76E=";

  nativeBuildInputs = [makeWrapper];

  # Patch INSTALL_ROOT to use XDG_CACHE_HOME instead of Nix store
  postInstall = ''
    substituteInPlace $out/lib/node_modules/sfw/dist/sfw.mjs \
      --replace-fail \
        'var INSTALL_ROOT = path2.resolve(__dirname2, "..");' \
        'var INSTALL_ROOT = process.env.XDG_CACHE_HOME ? path2.join(process.env.XDG_CACHE_HOME, "sfw") : path2.join(process.env.HOME || "/tmp", ".cache", "sfw");'
  '';

  meta = {
    description = "Socket Firewall - block malicious packages before install";
    homepage = "https://github.com/SocketDev/sfw-installer";
    license = lib.licenses.mit;
    platforms = ["aarch64-darwin"];
  };
}
