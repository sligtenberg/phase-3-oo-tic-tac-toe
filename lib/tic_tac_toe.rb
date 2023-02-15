require 'pry'

class TicTacToe
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        #  0 | 1 | 2
        #  ---------
        #  3 | 4 | 5
        #  ---------
        #  6 | 7 | 8
        [0,1,2], # top row
        [3,4,5], # middle row
        [6,7,8], # bottom row
        [0,3,6], # left col
        [1,4,7], # middle col
        [2,5,8], # right col
        [0,4,8], # diagonal
        [6,4,2]  # diagonal
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index input
        input.to_i - 1
    end

    def move (index, token = "X")
        @board[index] = token
    end

    def position_taken? index
        @board[index] == " " ? false : true
    end

    def valid_move? index
        position_taken?(index) == false && index.between?(0, 9) ? true : false
    end

    def turn_count
        count = 0
        @board.each do |location|
            if location != " "
                count += 1
            end
        end
        count
    end

    def current_player
        self.turn_count.even? ? "X" : "O"
    end

    # ask for input
    # get input
    # translate input into index
    # if index is valid
    #   make the move for index
    #   show the board
    # else
    #   restart turn
    # end

    def turn
        puts "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            move(index, self.current_player)
            self.display_board
        else
            self.turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.none? { |location| location == " " }
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.draw? || self.won?
    end

    def winner
        if self.won?
            return @board[self.won?[0]]
        else
            return nil
        end
    end

    # until the game is over
    #     take turns
    #   end
      
    #   if the game was won
    #     congratulate the winner
    #   else if the game was a draw
    #     tell the players it ended in a draw
    #   end

    def play
        while !self.over?
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"
        elsif self.draw?
            puts "Cat's Game!"
        end
    end
end