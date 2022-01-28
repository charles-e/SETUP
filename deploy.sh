#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SPL="$HOME/xxx/SAFE/safecoin-program-library"
export SP_LIB="$SPL/target/release";
export SRM="$HOME/xxx/SERUM-SAFE/bh-serumdex"
export SERUM="$SRM/target/release";
export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"

safecoin airdrop 100
safecoin config set -u d 
# FILES="$SPL/target/deploy/safe*.so"
# for f in $FILES
# do
#   echo "Processing $f file..."
#   # take action on each file. $f store current file name
#    safecoin program deploy $f
# done

safecoin program deploy --program-id PROGS/SERUM-2.json $SRM/dex/target/deploy/serum_dex.so 
