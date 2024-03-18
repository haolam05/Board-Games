require_relative 'board'
require_relative 'solver'

class Game
    attr_reader :board
    COMPUTER_SOLVER = true

    def initialize(name)
        @board = Board.new(name)
        @solver = ComputerSolver.new if COMPUTER_SOLVER
    end

    def play
        if COMPUTER_SOLVER
            board.render
            ask_computer_to_solve_sudoku
        else
            until board.solved?
                board.render
                prompt
                get_user_input
            end

            board.render
        end

        puts "YOU WIN!!"
    end

private
    def ask_computer_to_solve_sudoku
        @solver.solve(board)
    end

    def prompt
        puts "Please enter a position following by a value in this format: 00 9, where 00 is position and 9 is value"
    end

    def get_user_input
        puts "Here are a list of legal positions:\n#{board.legal_positions}"
        pos, val = gets.chomp.split(' ')
        pos = pos.split("").map(&:to_i)
        val = val.to_i
        board[pos] = val
    end
end

g1 = Game.new("./puzzles/sudoku1-almost.txt")
g1.play

g2 = Game.new("./puzzles/sudoku1-solved.txt")
g2.play

g3 = Game.new("./puzzles/sudoku1.txt")
g3.play

g4 = Game.new("./puzzles/sudoku2.txt")
g4.play

g5 = Game.new("./puzzles/sudoku3.txt")
g5.play

# Bonus
# You've written a Sudoku checker; now write a Sudoku solver.
# This is a harder problem, but there are several approaches you might take.
# As part of your approach, you may want to implement a separate Solver class,
# as well as a modified Tile class that keeps track of any previously-guessed values.
