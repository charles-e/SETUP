#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SP_LIB="$HOME/xxx/SAFE/safecoin-program-library/target/release";
export SERUM="$HOME/xxx/SERUM-SAFE/bh-serumdex/target/release";
export V4="$HOME/xxx/SERUM-SAFE/dex-v4/cranker/target/release";

export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"
export ME="$HOME/xxx/SAFE/CONFIG/mykey"
safecoin airdrop 500
export PROGID=$(safecoin-keygen pubkey PROGS/SERUM-2.json);
FILES="KEYS/*.json"
for f in $FILES
do
  CM="Safe111111111111111111111111111111111111111"
  for f2 in $FILES
    do
      if [ $f != $f2 ]; then
        PM=$(safecoin-keygen pubkey $f2);
        echo $CM / $PM 
        crank https://api.devnet.safecoin.org list-market --coin-mint $CM --pc-mint $PM $ME $PROGID
        else
        echo "skip"
    fi
  done
done


