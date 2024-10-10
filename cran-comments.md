## R CMD check results

── R CMD check results ──────────────────────────────────────────────────────────────────────────────────────── rtiktoken 0.0.1 ────
Duration: 45.3s

❯ checking installed package size ... NOTE
    installed size is 24.4Mb
    sub-directories of 1Mb or more:
      libs  24.3Mb

0 errors ✔ | 0 warnings ✔ | 1 note ✖

* This is a new release.

## Tarball size

I tried to reduce the size of the vendored rust dependencies as much as possible by using the tricks used by the `arcpbf` package (another Rust-wrapper R package).
As all Cargo/Rust dependencies are bundled (with largest possible compression), the tarball still has a size of 7.5 MB.
