class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message  
    @sequence_length += 1
  end

  def show_sequence
    add_random_color 
    @seq.each { |color| puts color }
    sleep(0.75)     
    system('clear')
  end

  def require_sequence
    puts "Repeat the sequence by entering the first letter of each color on a new line."
    seq.each do |color| 
      if color[0] != gets.chomp.downcase
        @game_over = true
        break 
      end
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Keep it up!"
  end

  def game_over_message
    puts "You lose!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

Simon.new.play