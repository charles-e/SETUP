#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SP_LIB="$HOME/xxx/SAFE/safecoin-program-library/target/release";
export SERUM="$HOME/xxx/SAFE/SERUM-SAFE/bh-serumdex/target/release";
export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"
safecoin airdrop 20
# create some tokens
FILES="KEYS/*.json"
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  safe-token -u d create-token $f
  safe-token -u d create-account $f
done
