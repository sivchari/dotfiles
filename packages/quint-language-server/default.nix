{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage {
  pname = "quint-language-server";
  version = "0.20.0";

  # VSCode Release v0.20.0 (the npm registry only has 0.19.0)
  src = fetchFromGitHub {
    owner = "quint-co";
    repo = "quint";
    rev = "fa8acd9e0dbb7c0b27bb5604515c0dd1bc7f4118";
    hash = "sha256-8gfuT70TYyqzO9ZJlYTucPQhOmqRlJ7up9RYogtColU=";
  };

  sourceRoot = "source/vscode/quint-vscode/server";

  npmDepsHash = "sha256-Y0p5mYc8JsjnsBz0MQCEZl41NoDQeq/zAwxNJBRA4fI=";

  npmBuildScript = "compile";

  # Upstream imports a type from vscode-languageclient, which only exists in
  # the parent (client) package; MarkupContent is also exported by -languageserver.
  postPatch = ''
    substituteInPlace src/complete.ts \
      --replace-fail "from 'vscode-languageclient'" "from 'vscode-languageserver'"
  '';

  meta = {
    description = "Language server for the Quint specification language";
    homepage = "https://github.com/quint-co/quint";
    license = lib.licenses.asl20;
    mainProgram = "quint-language-server";
    platforms = ["aarch64-darwin"];
  };
}
