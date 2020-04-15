#!/bin/bash

#constants
STAKE=100
BET=1
TOTAL_DAYS=20
WON=$(( $STAKE + $STAKE / 2 ))
LOST=$(( $STAKE / 2))

#Variables
numOfDays=0
numOfMonths=0
monthEarnedAmount=0

findDaysWonLost(){

	wonDays=0
	lostDays=0
	diffAmount=0

	for((k=0;k<${#dayWonLost[@]};k++))
	do
		if [ ${dayWonLost[k]} -eq $WON ]
		then
			((wonDays++))
		else
			((lostDays++))
		fi
	done

	echo "Number of days won:" $wonDays
	echo "Number of days lost:" $lostDays

	echo "Amount earned in month:" $monthEarnedAmount
	diffAmount=$(( $monthEarnedAmount - $(($STAKE*$TOTAL_DAYS)) ))

	if [ $monthEarnedAmount -gt $(($STAKE*$TOTAL_DAYS)) ]
	then
		echo "Won the month with amount:" $diffAmount
	else
		echo "Lost the month with amount:" $diffAmount
	fi
}

findLuckiestUnluckiestDay(){

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

dayPlay(){
	while true
	do
		if [ $cash -eq $LOST -o $cash -eq $WON ]
		then
			break
		fi

		res=$((RANDOM%2))

		if [ $res -eq 1 ]
		then
			cash=$(( $cash + $BET ))
		else
			cash=$(( $cash - $BET ))
		fi
	done
}

while true
do
	numOfDays=0
	monthEarnedAmount=0
	i=0
	while [ $numOfDays -lt $TOTAL_DAYS ]
	do
		cash=$STAKE
		((numOfDays++))

		#Invoking function dayPlay to play for the day
		dayPlay

		dayWonLost[((i++))]=$cash
		monthEarnedAmount=$(( $monthEarnedAmount + $cash ))
	done

	monthEarned[((j++))]=$monthEarnedAmount

	#Invoking function findDaysWonLost
	findDaysWonLost

	#Invoking function findLuckiestUnluckiestDay
	findLuckiestUnluckiestDay

	echo "Amount earned in days:" ${dayWonLost[@]}

	if [ $monthEarnedAmount -lt $(($STAKE*$TOTAL_DAYS)) ]
	then
		echo "This month lost money, so not going to play next month"
		echo "Amount earned in months:" ${monthEarned[@]}
		exit
	fi
done
