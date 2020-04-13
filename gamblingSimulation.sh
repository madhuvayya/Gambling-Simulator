#!/bin/bash -x

STAKE=100
BET=1
TOTAL_DAYS=20
WON=150
LOST=50

numDays=0
totalAmount=0
wonDays=0
lostDays=0

i=0
while [ $numDays -lt $TOTAL_DAYS ]
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

	dayWonLost[((i++))]=$cash
	totalAmount=$(($totalAmount+$cash))
done

echo $totalAmount

daysWonLost(){
	for((k=0;k<${#dayWonLost[@]};k++))
	do
		if [ ${dayWonLost[k]} -eq $WON ]
		then
			((wonDays++))
		else
			((lostDays++))
		fi

		totalAmountMonth=$(($totalAmount+$cash))
	done

	echo "Number of days won: $wonDays"
	echo "Number of days lost: $lostDays"

	amount=$(($totalAmountMonth-$(($STAKE*$TOTAL_DAYS))))

	if [ $amount -gt $(($STAKE*$TOTAL_DAYS)) ]
	then
		echo "Won the month with amount: $amount"
	else
		echo "Lost the month with amount: $amount"
	fi
}


daysWonLost
