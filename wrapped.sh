#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SP_LIB="$HOME/xxx/SAFE/safecoin-program-library/target/release";
export SERUM="$HOME/xxx/SAFE/SERUM-SAFE/bh-serumdex/target/release";
export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"
export ME="$HOME/xxx/SAFE/CONFIG/mykey"
safecoin airdrop 500
PROGID=$(safecoin-keygen pubkey PROGS/SERUM-2.json);
FILES="KEYS/*.json"
for f in $FILES
do
  CM=$(safecoin-keygen pubkey $f);

        PM=Safe111111111111111111111111111111111111112
        echo $CM / $PM 
        crank https://api.testnet.safecoin.org list-market --coin-mint $CM --pc-mint $PM $ME $PROGID
      
done


