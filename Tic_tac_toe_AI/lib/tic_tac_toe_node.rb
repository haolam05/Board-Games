require_relative 'tic_tac_toe'   

class TicTacToeNode   
  attr_reader :board, :next_mover_mark, :prev_move_pos
  #   class instance   value(:x OR :o)  parent [i, j]
  #   children array: where the children of each self is the next possible moves + all of its parents, grandparents
  #   represented on the board. so the BOARD CAN BE CONSIDERED AS CHILDREN

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
  end

  def children
    children = []

    board.rows.each_with_index do |rows, i|
      rows.each_with_index do |val, j| #val.nil? || next unless board.empty?([i,j])
        children << TicTacToeNode.new(board.dup, next_mover_mark == :x ? :o : :x, [i,j]) if val.nil?
        children.last.board[[i,j]] = next_mover_mark if val.nil?
      end
    end

    children
  end
    
  def losing_node?(player)
    return board.won? && board.winner != player if board.over?
    player == next_mover_mark ? children.all? { |child| child.losing_node?(player) } : children.any? { |child| child.losing_node?(player) }
  end

  def winning_node?(player)
    return board.won? && board.winner == player if board.over?
    player == next_mover_mark ? children.any? { |child| child.winning_node?(player) } : children.all? { |child| child.winning_node?(player) }
  end
end

# PolyTreeNode Data Structure Application
#     computer      : when current player is computer, it chooses randomly from given legal positions for its next move
#     supercomputer : when current player is computer, 
#                     1) it chooses a move that leads to a winning scenario(winning_move) if available, if no such scenario, 
#                     2) it chooses a move that blocks the opponent winning move if available, if no such scenario,
#                     3) it raises an error and stop the game immediately
#                       => never lose

#                   in order to generate winning and losing moves(scenarios), we create a class to take care of this logic, TicTacToeNode
#                   this class is a data structure in which each class instance has 
#                     1) a value  =>  :x or :o
#                     2) a parent =>  an array of position of previous move [i,j]
#                     3) children =>  children is represented under a board(2D array), which includes current scenario
#                       Specifically, each children is a scenario.
#                       example: 
# Parent:     0 1 2     suppose computer is , value :x
#           0 _ _ _     
#           1 _ _ _
#           2 _ _ _   

# Children:   0 1 2       0 1 2      0 1 2  , value :o     
#           0 x _ _     0 _ x _    0 _ _ x
#           1 _ _ _     1 _ _ _    1 _ _ _
#           2 _ _ _     2 _ _ _    2 _ _ _

#             0 1 2       0 1 2      0 1 2      
#           0 _ _ _     0 _ _ _    0 _ _ _
#           1 x _ _     1 _ x _    1 _ _ x
#           2 _ _ _     2 _ _ _    2 _ _ _

#             0 1 2       0 1 2      0 1 2      
#           0 _ _ _     0 _ _ _    0 _ _ _
#           1 _ _ _     1 _ _ _    1 _ _ _
#           2 x _ _     2 _ x _    2 _ _ x

#           Parent:     0 1 2
#                     0 x _ _
#                     1 _ _ _    
#                     2 _ _ _     
#           Children:   0 1 2       0 1 2      0 1 2  , value :x     
#                     0 x o _     0 x _ o    0 x _ _
#                     1 _ _ _     1 _ _ _    1 o _ _
#                     2 _ _ _     2 _ _ _    2 _ _ _

#                       0 1 2       0 1 2      0 1 2      
#                     0 x _ _     0 x _ _    0 x _ _
#                     1 _ o _     1 _ _ o    1 _ _ _
#                     2 _ _ _     2 _ _ _    2 o _ _

#                       0 1 2       0 1 2           
#                     0 x _ _     0 x _ _ 
#                     1 _ _ _     1 _ _ _    
#                     2 _ o _     2 _ _ o   

#                       Parent:     0 1 2
#                                 0 x o _
#                                 1 _ _ _        
#                                 2 _ _ _         
#                       Children:   0 1 2       0 1 2      0 1 2  , value :o     
#                                 0 x o x     0 x o _    0 x o _
#                                 1 _ _ _     1 x _ _    1 _ x _
#                                 2 _ _ _     2 _ _ _    2 _ _ _

#                                   0 1 2       0 1 2      0 1 2      
#                                 0 x o _     0 x o _    0 x o _
#                                 1 _ _ x     1 _ _ _    1 _ _ _
#                                 2 _ _ _     2 x _ _    2 _ x _

#                                   0 1 2                
#                                 0 x o _    
#                                 1 _ _ _      
#                                 2 _ _ x   
                                
#                                   Parent:     0 1 2
#                                             0 x o x
#                                             1 _ _ _
#                                             2 _ _ _ 
#                                   Children:   0 1 2       0 1 2      0 1 2  , value :x    
#                                             0 x o x     0 x o x    0 x o x
#                                             1 o _ _     1 _ o _    1 _ _ o
#                                             2 _ _ _     2 _ _ _    2 _ _ _

#                                               0 1 2       0 1 2      0 1 2      
#                                             0 x o x     0 x o x    0 x o x
#                                             1 _ _ _     1 _ _ _    1 _ _ _
#                                             2 o _ _     2 _ o _    2 _ _ o

#                                               Parent:     0 1 2
#                                                         0 x o x
#                                                         1 o _ _
#                                                         2 _ _ _ 
#                                               Children:   0 1 2       0 1 2      0 1 2  , value :o    
#                                                         0 x o x     0 x o x    0 x o x
#                                                         1 o x _     1 o _ x    1 o _ _
#                                                         2 _ _ _     2 _ _ _    2 x _ _

#                                                           0 1 2       0 1 2       
#                                                         0 x o x     0 x o x   
#                                                         1 o _ _     1 o _ _   
#                                                         2 _ x _     2 _ _ x   

#                                                           Parent:     0 1 2
#                                                                     0 x o x
#                                                                     1 o x _
#                                                                     2 _ _ _ 
#                                                           Children:   0 1 2       0 1 2      0 1 2  , value :x    
#                                                                     0 x o x     0 x o x    0 x o x
#                                                                     1 o x o     1 o x _    1 o x _
#                                                                     2 _ _ _     2 o _ _    2 _ o _

#                                                                       0 1 2          
#                                                                     0 x o x       
#                                                                     1 o x _     
#                                                                     2 _ _ o
                                                                    
#                                                                       Parent:     0 1 2
#                                                                                 0 x o x
#                                                                                 1 o x o
#                                                                                 2 _ _ _ 
#                                                                       Children:   0 1 2       0 1 2      0 1 2  , value :o    
#                                                                                 0 x o x     0 x o x    0 x o x
#                                                                                 1 o x o     1 o x o    1 o x o
#                                                                                 2 x _ _     2 _ x _    2 _ _ x
                                                                    
#                                                                                   Parent:     0 1 2
#                                                                                             0 x o x
#                                                                                             1 o x o
#                                                                                             2 x _ _ 
#                                                                                   Children:   0 1 2       0 1 2  , value :x    
#                                                                                             0 x o x     0 x o x    
#                                                                                             1 o x o     1 o x o    
#                                                                                             2 x o _     2 x _ o  

#                                                                                               Parent:     0 1 2
#                                                                                                         0 x o x
#                                                                                                         1 o x o
#                                                                                                         2 x o _ 
#                                                                                               Children:   0 1 2   , value :o    
#                                                                                                         0 x o x        
#                                                                                                         1 o x o        
#                                                                                                         2 x o x    

#                                                                                             board.over? == true
#                                                                                     return  board.won? &&  board.winner == player
#                                                                                             true        && true
                                                                                            
#                                                                                             WIN!!!

#                       when generating winning or losing moves, we simply find all possible scenarios(moves) of parents,
#                       then all possible scenarios(moves) of  each of the children, and so on until the board is over.
#                       1) when generating winning nodes
#                         we check to see if 
#                  our turn i) out of all possible scenarios(moves-children array), there is at least one scenario that leads us to winning
#                               => we will be smart enough to take that move-scenario(s) to win.
#             opponent turn ii) out of all possible scenarios(moves-children array), all moves/scenarios are winning move(for us)
#                               => we will win no matter what. no matter where they opponent goes, we will always win

#                       2) when generating losing nodes
#                         we check to see if
#                  our turn i) out of all possible scenarios(moves-children array), all moves/scenarios are losing move(for us)
#                               => we will lose anyway, no matter where we go
#             opponent turn ii) out of all possible scenarios(moves-children array), there is at least one scenario that leads us to losing
#                               => the opponent will be smart enough to take that move, so we lose.

# Make sure : we need to make a duplicate of the grids(2D array) when creating a copy a new Board instance
# Logic to win/lose : board must be over  (s/o had won OR tied)
#                     if s/o had won? && the player is the winner?
#                       true => winning node, false => not a winning node
#                     if s/o had won? && the player is NOT the winner?
#                       true => losing node, false => not a losing node
