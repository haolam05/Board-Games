class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  #PART I
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return false if !attempted_chars.include?(char)
    true
  end

  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index { |el, idx| arr << idx if char == el }
    arr
  end

  def fill_indices(char, indices)
    indices.each { |idx| @guess_word[idx] = char }
  end

  #PART II
  def try_guess(char)
    if already_attempted?(char)
          puts 'that has already been attempted'
          return false
    else
      @attempted_chars << char
      fill_indices(char, get_matching_indices(char))
      @remaining_incorrect_guesses -= 1 if get_matching_indices(char).length == 0
    end
    true
  end

  def ask_user_for_guess
    puts 'Enter a char:'
    try_guess(gets.chomp)
  end

  def win?
    return false if @guess_word.join('') != @secret_word
    puts 'WIN'
    true
  end

  def lose?
    return false if @remaining_incorrect_guesses != 0
    puts 'LOSE'
    true
  end

  def game_over?
    return false if !win? && !lose?
    puts @secret_word
    true
  end
end
