#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SP_LIB="$HOME/xxx/SAFE/safecoin-program-library/target/release";
export SERUM="$HOME/xxx/SAFE/SERUM-SAFE/bh-serumdex/target/release";
export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"
safecoin airdrop 20
# create some tokens
FILES="KEYS/*.json"
USERS="worker*.json"
which safe-token
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  TNAME=$(safecoin-keygen pubkey $f)
  echo $TNAME
  echo "safe-token -u d create-account $TNAME"
  safe-token -u d create-account $TNAME
  echo "safe-token -u d mint $TNAME 1000"
  safe-token -u d mint $TNAME 1000
  for u in $USERS
  do
    UNAME=$(safecoin-keygen pubkey $u)
    safe-token -u d transfer --allow-unfunded-recipient --fund-recipient $TNAME 100 $UNAME
  done
done
