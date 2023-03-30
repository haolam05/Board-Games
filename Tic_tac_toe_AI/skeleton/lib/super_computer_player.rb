require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    possible_moves = TicTacToeNode.new(game.board, mark).children.shuffle
    possible_moves.each { |child| return child.prev_move_pos if child.winning_node?(mark) }
    possible_moves.each { |child| return child.prev_move_pos if !child.losing_node?(mark) }
    raise
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end

# class SuperComputerPlayer < ComputerPlayer
#   def move(game, mark)
#     game.board.rows.each { |row| p row }
#     puts '---------------'
#     possible_moves = TicTacToeNode.new(game.board, mark).children.shuffle
#     possible_moves.each do |child| 
#       child.board.rows.each { |row| p row }
#       puts '---------------'
#       return child.prev_move_pos if child.winning_node?(mark) 
#     end
#     possible_moves.each { |child| return child.prev_move_pos if !child.losing_node?(mark) }
#     raise
#   end
# end