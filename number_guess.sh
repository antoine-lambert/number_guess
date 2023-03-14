#!/bin/bash

echo NUMBER=$(( $RANDOM % 999 + 1 ))
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER=$($PSQL "SELECT name FROM users WHERE name='$USERNAME';")
if [[ -z $USER ]]
  then
  $PSQL "INSERT INTO users(name, games_played, best_game, number_of_guesses) VALUES('$USERNAME', 0, 0, 0)"
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  else echo "Welcome back, $USERNAME! You have played 0 games"
fi

echo "Guess the secret number between 1 and 1000:"
read GUESS

while [[ $GUESS -ne $NUMBER ]]
do
  if [[ $GUESS != [0-9]* ]]
    then
    echo "That is not an integer, guess again:"
    read GUESS

  elif [[ $GUESS < $NUMBER ]]
    then 
    echo "It's higher than that, guess again:"
    #$PSQL "UPDATE users SET games_played+=1"
    read GUESS

  elif [[ $GUESS > $NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    read GUESS

    fi
done

    echo "You guessed it in tries. The secret number was $NUMBER. Nice job!"