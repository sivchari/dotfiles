{
  lib,
  rustPlatform,
  fetchFromGitHub,
  libiconv,
}:
rustPlatform.buildRustPackage {
  pname = "btmon";
  version = "unstable-2026-03-25";

  src = fetchFromGitHub {
    owner = "sivchari";
    repo = "btmon";
    rev = "9e3c7dabf41bf4a575615e51cb0eed5059214d93";
    hash = "sha256-/VXfg+twQLJ8w6eYIja2AcdayKsYIzNdr4hMnuAMtmg=";
  };

  cargoHash = "sha256-QhONTbJMqI2EunfmzXWgWbZFhsyS1OA+7aLP/2srEgQ=";

  buildInputs = [
    libiconv
  ];

  meta = {
    description = "Bluetooth battery monitor for macOS";
    homepage = "https://github.com/sivchari/btmon";
    license = lib.licenses.mit;
    platforms = ["aarch64-darwin"];
  };
}
