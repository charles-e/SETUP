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
  TNAME=$(safecoin-keygen pubkey $f)
  echo $TNAME
  safe-token -u t transfer  --fund-recipient --allow-unfunded-recipient $TNAME 500 52CmjRqbx87Ns7dWBr2ncXHzViJ9sUzRsBJhVvZMNhCD
done
