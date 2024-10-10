# to be run fron src/rust
cargo vendor
XZ_OPT='-9' tar -cJf vendor.tar.xz vendor
rm -rf vendor
