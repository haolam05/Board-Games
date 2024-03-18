class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  #PART I
  attr_reader :pegs

  def self.valid_pegs?(chars_arr)
    chars_arr.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def initialize(chars_arr)
    raise if !Code.valid_pegs?(chars_arr)
    @pegs = chars_arr.map(&:upcase)
  end

  def self.random(length)
    Code.new(Array.new(length, POSSIBLE_PEGS.keys[rand(0..3)]))
  end

  def self.from_string(str)
    Code.new(str.split(''))
  end

  def [](i)
    @pegs[i]
  end

  def length
    @pegs.length
  end

  #PART II
  def num_exact_matches(code_instance)
    (0...@pegs.length).count { |i| @pegs[i] == code_instance[i] }
  end

  def num_near_matches(code_instance)
    (0...code_instance.pegs.length).count { |i| @pegs[i] != code_instance[i] && @pegs.include?(code_instance[i]) }
  end

  def ==(code_instance)
    code_instance.pegs == @pegs
  end
end
