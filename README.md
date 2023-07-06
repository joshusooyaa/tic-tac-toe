# Overview
A simple tic-tac-toe project used to improve on coding in Ruby.

# Problem
Tic-tac-toe involves three major components:
1. The board
2. The players
3. The game itself

## The Board
The board is essential to keep track of the game's status. Without a board, how would the players know who is winning, or where to even put their x or o? Although obvious, this is crutial for solving this problem. Therefore, a class to maintain the game's status through a `Board` class will be the foundation of solving this problem.

The next step is figuring out what goes into the class. Well, a tic-tac-toe board has 9 squares. This is what we'll start with for this class. However, it doesn't make sense to make these all individual variables -- therefore we'll create a 3x3 2D array in which the board state will saved through. 

## The players
Tic-tac-toe involves two players - an 'x' player and a 'o' player. A `Player` class isn't all too important if the game doesn't have a state, but if we chose to keep score between two players across rounds, then a `Player` class becomes more important. If we weren't keeping score, then the turn of a player can simply be saved through a turn variable saved in the `Game` class. 

With the use of a `Player` class we'll have three variables: name, player_marker, and score. The "name" isn't important, but for the sake of making it a more complete game, it'll be used. The player marker is fairly important, as it will be what's used to determine who goes first. Score, as stated before, will be used to store information of how many games the player has won.

## The Game
This is the most important aspect of the game. It's, well, the game itself. It'll use the board and the players to keep track of the game state and determine the winner (or if there is a tie) based on several factors. 

The `Game` class will need two variables:
1. Instance variable: `Board`
2. Instance variable: `Player` (x2)
3. Turn (who's move it is)

Additionally, since `Game` will be responsibile for running the game, several methods are necessary to do so:
1. Move - determine who's move it is
2. Check win - determine if someone has won or not
3. Helper methods to restart the game (and or rounds) when someone wins/loses or ties


# Acknowledgements
[The Odin Project](https://www.theodinproject.com/lessons/ruby-tic-tac-toe)
