#!/bin/bash -x

STAKE=100
BET=1


while true
do
	cash=$STAKE

	while true
	do
		if [ $cash -eq $(($STAKE/2)) -o $cash -eq $(($STAKE+$STAKE/2)) ]
		then
			echo $cash
			break
		fi

		res=$((RANDOM%2))

		if [ $res -eq 1 ]
		then
			cash=$(($cash+$BET))
		else
			cash=$(($cash-$BET))
		fi
	done
done
