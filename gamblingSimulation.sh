#!/bin/bash -x

STAKE=100
BET=1

cash=$STAKE

while true
do
	res=$((RANDOM%2))

	if [ $res -eq 1 ]
	then
		cash=$(($cash+$BET))
	else
		cash=$(($cash-$BET))
	fi

	echo $cash
done
