#!/bin/sh
export SAFE="$HOME/xxx/SAFE/bh-safecoin-v2/target/release";
export SP_LIB="$HOME/xxx/SAFE/safecoin-program-library/target/release";
export SERUM="$HOME/xxx/bh-serumdex/target/release";
export PATH="$SAFE:$SERUM:$SP_LIB:$PATH"
export ME="$HOME/xxx/SAFE/CONFIG/mykey"
safecoin airdrop 500
export PROGID=$(safecoin-keygen pubkey PROGS/SERUM-2.json);
export CLUSTER=https://api.testnet.safecoin.org 


export MARKET="RNvwovSsjLoE5qhShdLcg1vRqaWW8YVxyvjwgwSohMM"; # Dai / SAF
export JSON1="./worker.json"
export JSON2="./worker2.json"
export JSON3="./worker3.json"
export JSON4="./worker4.json"

export W1=$(safecoin-keygen pubkey $JSON1);
export W2=$(safecoin-keygen pubkey $JSON2);
export W3=$(safecoin-keygen pubkey $JSON3);
export W4=$(safecoin-keygen pubkey $JSON4);

safecoin airdrop 10 $W1
safecoin airdrop 10 $W2

safe-token transfer --fund-recipient --allow-unfunded-recipient daidbvnDAyMsWuDCZb8u4kArE8owvotaL3ENua5baKF 100 $W1;
safe-token transfer --fund-recipient --allow-unfunded-recipient daidbvnDAyMsWuDCZb8u4kArE8owvotaL3ENua5baKF 100 $W2;
safe-token transfer --fund-recipient --allow-unfunded-recipient SAFdssqXC6pnewMdWGWfL6zTsoLV8Yz4LbvqKjUieoQ 100 $W1;
safe-token transfer --fund-recipient --allow-unfunded-recipient SAFdssqXC6pnewMdWGWfL6zTsoLV8Yz4LbvqKjUieoQ 100 $W2;
# safe-token accounts daidbvnDAyMsWuDCZb8u4kArE8owvotaL3ENua5baKF --owner $W1 --verbose = 927D3WRXJBMswNihGbdyBrdaRYULHCt68pDWqepack8p (coin)
# safe-token accounts SAFdssqXC6pnewMdWGWfL6zTsoLV8Yz4LbvqKjUieoQ --owner $W1 --verbose = 2YbF4WKR73UPBwEboaHeju7KKjWN2UgQvesRgBLzaRBU (pc)
# safe-token accounts daidbvnDAyMsWuDCZb8u4kArE8owvotaL3ENua5baKF --owner $W2 --verbose = EkjyNyV2i4PZF6S6j99yiiPVRheqhEqfyNNVcfBkwY4y (coin)
# safe-token accounts SAFdssqXC6pnewMdWGWfL6zTsoLV8Yz4LbvqKjUieoQ --owner $W2 --verbose = AkT9aSRQdULqyiHrNQun74FVuZ1V2m9atwMd5FKkBkEP  (pc)

crank create-orders --market-id $W1 

# seller = W1 buyer = W2

crank $CLUSTER create-orders-account --market-id $MARKET $JSON1 $PROGID # D4WhqPqJBeQDs4mDf3QYemEGmeAZpzxU8RB1aCERXKPS
crank $CLUSTER create-orders-account --market-id $MARKET $JSON2 $PROGID # DyMrxeNmGEDqdeqNQR64Uy2cSKsRf4pkbo823rxMwo5x
export ORDERS1=D4WhqPqJBeQDs4mDf3QYemEGmeAZpzxU8RB1aCERXKPS
export ORDERS2=DyMrxeNmGEDqdeqNQR64Uy2cSKsRf4pkbo823rxMwo5x


crank $CLUSTER order-existing --market-id $MARKET  --coin-wallet 2YbF4WKR73UPBwEboaHeju7KKjWN2UgQvesRgBLzaRBU --open-orders-id $ORDERS1 --order-params "S:1000000:10" $JSON1 $PROGID # sell SAF

crank $CLUSTER order-existing --market-id $MARKET  --coin-wallet EkjyNyV2i4PZF6S6j99yiiPVRheqhEqfyNNVcfBkwY4y --open-orders-id $ORDERS2 --order-params "B:1000000:11" $JSON2 $PROGID # buy using DAI

crank $CLUSTER check-events --market $MARKET  --pc-wallet AkT9aSRQdULqyiHrNQun74FVuZ1V2m9atwMd5FKkBkEP --coin-wallet 927D3WRXJBMswNihGbdyBrdaRYULHCt68pDWqepack8p  $ME $PROGID


# settle funds for W1
crank $CLUSTER settle-funds $JSON1 $PROGID $MARKET  $ORDERS1 927D3WRXJBMswNihGbdyBrdaRYULHCt68pDWqepack8p 2YbF4WKR73UPBwEboaHeju7KKjWN2UgQvesRgBLzaRBU 

# settle funds for W2
crank $CLUSTER settle-funds $JSON2 $PROGID $MARKET  $ORDERS2 EkjyNyV2i4PZF6S6j99yiiPVRheqhEqfyNNVcfBkwY4y AkT9aSRQdULqyiHrNQun74FVuZ1V2m9atwMd5FKkBkEP 