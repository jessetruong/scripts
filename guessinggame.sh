#!/bin/bash
# A challenge for Chapter 4 of Up and Running with Bash Scripts
#
# Write a simple guessing game, using interactive input and a test condition. 
#+Also, build the program so that it responds to a command line argument
#+and also has a function if no argument is specified. Use a function as well.

function randomnumber {
	num=$RANDOM
	((num%=$1))
	array=( $(eval echo {1..$1..$(($num/10))}) )
	index=$(($num % ${#array[@]}))
	echo ${array[$index]}
}

select difficulty in "easy" "normal" "difficult"; do
	echo
	case $difficulty in
		easy|normal|difficult) 
			echo "You selected $difficulty!"
			break
			;;
		*)
			echo "Please select a difficulty";;
	esac
done

timestart=$(date +%s)

case $difficulty in
	"easy") limit=10;;
	"normal") limit=100;;
	"difficult") limit=1000;;
esac

answer=$(randomnumber $limit)

echo "Please give your guess [1-$limit]: "
read input

until [ $input -eq $answer ]; do
	echo "This is your input: $input"
	if [ $input -gt $answer ]; then
		echo "You guessed too high!"
	elif [ $input -lt $answer ]; then
		echo "You guessed too low!"
	fi
	read input
done

timeend=$(date +%s)
timefinish=$(($timeend-$timestart))

echo
echo "You took $timefinish seconds to guess the right number!"
