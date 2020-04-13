#!/bin/bash

STAKE=100
BET=1
TOTAL_DAYS=20
WON=150
LOST=50

numDays=0
monthEarnedAmount=0
wonDays=0
lostDays=0
diffAmount=0

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

	diffAmount=$(($totalAmountMonth-$(($STAKE*$TOTAL_DAYS))))

	if [ $diffAmount -gt $(($STAKE*$TOTAL_DAYS)) ]
	then
		echo "Won the month with amount: $diffAmount"
	else
		echo "Lost the month with amount: $diffAmount"
	fi
}

luckiestUnluckiestDay(){

	max=${dayWonLost[0]}
	min=${dayWonLost[0]}

	for((l=1;l<${#dayWonLost[@]};l++))
	do
		if [ $max -lt ${dayWonLost[$l]} ]
		then
			max=${dayWonLost[$l]}
		fi

		if [ $min -gt ${dayWonLost[$l]} ]
		then
			min=${dayWonLost[$l]}
		fi
	done

	echo "Luckiest day: $max"
	echo "Unluckiest day: $min"
}

while true
do
	i=0
	while [ $numDays -lt $TOTAL_DAYS ]
	do
		cash=$STAKE
		((numDays++))

		while true
		do
			if [ $cash -eq $(($STAKE/2)) -o $cash -eq $(($STAKE+$STAKE/2)) ]
			then
				#echo $cash
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
		monthEarnedAmount=$(($monthEarnedAmount+$cash))
	done

	echo "Amount earned in month: $monthEarnedAmount"

	daysWonLost

	luckiestUnluckiestDay

	if [ $diffAmount -lt $(($STAKE*$TOTAL_DAYS)) ]
	then
		echo "Lost this month so not going to play next month"
		exit
	fi
done
