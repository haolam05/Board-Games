class ComputerSolver
    def solve(board)
        @board = board

        if board.solved?
            board.render
            exit
        else
            all_possible_numbers.each do |num|
                board.legal_positions.each do |pos|
                    if safe?(pos, num)
                        choose(pos, num)
                        solve(board)
                        unchoose(pos)
                    end
                end
            end
        end
    end

private
    def choose(pos, num)
        @board[pos] = num
    end

    def unchoose(pos)
        @board[pos].reset
    end

    def safe?((x,y), num)    
        horizontal_is_safe = (0...@board.length).all? { |i| @board[[x,i]].val != num }
        vertical_is_safe = (0...@board.length).all? { |i| @board[[i,y]].val != num }
        block_is_safe = find_block([x,y]).all? { |pos| @board[pos].val != num }
        horizontal_is_safe && vertical_is_safe && block_is_safe
    end

    def find_block(pos)
        @board.blocks.each { |block| return block if block.include?(pos) }
    end

    def all_possible_numbers
        (1..9).to_a
    end
end