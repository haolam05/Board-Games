require 'byebug'

class Board
  attr_accessor :cups, :player1, :player2

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    @cups = Array.new(14) { [] }
    @cups = place_stones
  end

  def place_stones # helper method to #initialize every non-store cup with four stones each
    cups.map.with_index { |cup, i| (i != 6 && i != 13) ? [:stone] * 4 : cup }
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(0,13)
    raise "Starting cup is empty" if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    ending_idx = @cups[start_pos].count + start_pos
    stones = @cups[start_pos]
    @cups[start_pos] = []
    
    i = start_pos + 1
    until stones.empty? do
      @cups[i % 14] << stones.pop if i % 14 != (current_player_name == player1 ? 13 : 6)
      i += 1
    end

    render
    next_turn(ending_idx % 14)
  end
                                #helper method to determine whether #make_move
  def next_turn(ending_cup_idx) #returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
    cups[ending_cup_idx].count == 1 ? :switch : ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts "" * 2
  end

  def one_side_empty?
    (0..5).all? { |i| cups[i].empty? } || (7..12).all? { |i| cups[i].empty? }
  end

  def winner
    cups[6].count == cups[13].count ? :draw : (cups[6].count > cups[13].count ? player1 : player2 )
  end
end