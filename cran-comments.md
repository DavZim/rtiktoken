Note for submit of version 0.11.0.1:

- update rextendr dependency, removes the "found non-API call to R" note
- reduces installation size (note as this bundles the tiktoken crate, its still around 12Mb, see NOTE). Unfortunately, the size cannot be further reduced.
- comment on the version. While we use semver, the current version signals that we depend on 0.11.0 of the underlying crate, but the internals of the R part have changed, hence .1
