# Game of Battleships

## Overview
This is a simulation of the classic Battleships game implemented in Ruby on Rails. The game is played between two players on an MxM grid, where each player places a specified number of ships. The objective is to destroy the opponent's ships using a set number of missiles. The player who inflicts the most damage wins.

## Features
- **Grid Initialization**: Players are initialized with a grid and a set number of ships.
- **Missile Attacks**: Each player can make a specified number of missile attacks.
- **Simultaneous Firing**: The game supports simultaneous missile firing for both players.
- **Winner Determination**: The game determines the winner based on the number of successful hits.



# Installation
### Take git clone :      
`git clone https://github.com/shimroz1992/battleship_test_task.git`
### Change into the project directory:   
`cd battleship_test_task`

### Install Dependencies:    
`bundle install`  
`rails db:create`

`rails db:migrate`

### Run the Server:
`rails server`   
or  
`rails s`

### Input Format:    
The input for the game will be read from a file `(input.txt)` containing the following information (one item per line) in a root directory:

1. `M` - The size of the battleground grid (Matrix of M*M), where 0 < M < 10
2. `S` - The number of ships, where 0 < S <= M^2/2
3. Player 1 ship positions in the format `x1,y1:x2,y2:...` (x,y pairs separated by colons)
4. Player 2 ship positions in the format `x1,y1:x2,y2:...` (x,y pairs separated by colons)
5. `T` - The total number of missiles, where 0 < T < 100
6. Player 1 moves in the format `a1,b1:a2,b2:...` (x,y pairs of length `T`)
7. Player 2 moves in the format `a1,b1:a2,b2:...` (x,y pairs of length `T`)

### Sample Input File    

`5`   
`5`  
`1,1:2,0:2,3:3,4:4,3`   
`0,1:2,3:3,0:3,4:4,1`   
`5`   
`0,1:4,3:2,3:3,1:4,1`   
`0,1:0,0:1,1:2,3:4,3`   

## Output Format
The output will generate to a file named `output.txt`. The file will contain the following information:

1. The final state of Player 1's grid after all moves.
2. The final state of Player 2's grid after all moves.
3. The number of hits achieved by Player 1 (`P1: total hits`).
4. The number of hits achieved by Player 2 (`P2: total hits`).
5. The result of the game (`Game Result`).

### Run the game using the rake task:    
`rails battleship:play
`


### Sample Output File    

`Player1`   
`O O _ _ _`  
`_ X _ _ _`  
`B _ _ X _`  
`_ _ _ _ B`  
`_ _ _ X _`   
     
`Player2`   
`_ X _ _ _`   
`_ _ _ _ _`   
`_ _ _ X _`   
`B O _ _ B`   
`_ X _ O _`   
`P1:3`   
`P2:3`   
`It is a draw`   

### Add RSpec to the Gemfile:
Open your project's Gemfile and add the rspec-rails gem to the :development, :test group.  

`gem 'rspec-rails'`  
`bundle install`

### Initialize RSpec:
`rails generate rspec:install`

### Run RSpec:
You can now run RSpec to execute your tests.

`rspec`  


     

## Happy coding!
