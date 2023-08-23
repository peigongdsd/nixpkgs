{ stdenv
, lib
, fetchCrate
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-llvm-cov";
  version = "0.5.28";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-B+tyDVb/tSuxQAK8x5cEw+Y7Y5IXD+jkr0FeqiDY+g8=";
  };
  cargoSha256 = "sha256-lGaMws7Z7qIWkQlfnSnN9cqRojBuxWp81nMAlBXAWEM=";

  # skip tests which require llvm-tools-preview
  checkFlags = [
    "--skip bin_crate"
    "--skip cargo_config"
    "--skip clean_ws"
    "--skip instantiations"
    "--skip merge"
    "--skip merge_failure_mode_all"
    "--skip no_test"
    "--skip open_report"
    "--skip real1"
    "--skip show_env"
    "--skip virtual1"
  ];

  meta = rec {
    homepage = "https://github.com/taiki-e/${pname}";
    changelog = homepage + "/blob/v${version}/CHANGELOG.md";
    description = "Cargo subcommand to easily use LLVM source-based code coverage";
    longDescription = ''
      In order for this to work, you either need to run `rustup component add llvm-
      tools-preview` or install the `llvm-tools-preview` component using your Nix
      library (e.g. fenix or rust-overlay)
    '';
    license = with lib.licenses; [ asl20 /* or */ mit ];
    maintainers = with lib.maintainers; [ wucke13 matthiasbeyer ];
  };
}
