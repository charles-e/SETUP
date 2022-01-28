#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SP_LIB="$HOME/xxx/SAFE/safecoin-program-library/target/release";
export SERUM="$HOME/xxx/SAFE/SERUM-SAFE/bh-serumdex/target/release";
export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"
export ME="$HOME/xxx/SAFE/CONFIG/mykey"

FILES="KEYS/*.json"
for f in $FILES
do
  for f2 in $FILES
    do
    if [ $f != $f2 ]; then
        echo $f $f2;
    else
        echo "skip"
    fi
  done
done


