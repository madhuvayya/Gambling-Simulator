#!/bin/bash -x

STAKE=100
BET=1
TOTAL_DAYS=20

numDays=0
totalAmount=0

while [ $numDays -le $TOTAL_DAYS ]
do
	cash=$STAKE
	((numDays++))

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

	totalAmount=$(($totalAmount+$cash))
done

echo $totalAmount
