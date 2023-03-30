class Player
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess(fragment, dictionary, number_of_other_players)
        puts "Current fragment is: '#{fragment}'."
        puts "It's #{name}'s turn"
        print "Add a leter: "
        gets.chomp.downcase
    end

    def alert_invalid_guess(letter)
        puts "#{letter} is not a valid move!"
        puts "Your guess must be a letter of the alphabet."
        puts "You must be able to form a word starting with the new fragment.\n"
    end
end

class AiPlayer < Player
    def guess(fragment, dictionary, number_of_other_players)
        safe_length = fragment.length + number_of_other_players + 1
        winning_letter = pick_winning_move(dictionary, fragment, safe_length)
        winning_letter.nil? ? pick_random_move(dictionary, fragment) : winning_letter
    end

    def pick_winning_move(dictionary, fragment, safe_length)
        ('a'..'z').to_a.each { |letter| return letter if winning_move?(dictionary, fragment + letter, safe_length) }
        nil
    end

    def winning_move?(dictionary, new_word, safe_length)
        new_dict = update_dictionary(dictionary, new_word)
        new_dict.length > 0 && new_dict.all? { |word| !losing_move?(dictionary, word) && word.length < safe_length }
    end

    def pick_random_move(dictionary, fragment)
        max = ''
        new_dict = update_dictionary(dictionary, fragment)
        new_dict.each.with_index { |word, i| max = word if word.length > max.length } 
        new_dict[new_dict.index(max)][fragment.length]
    end

    def update_dictionary(dictionary, new_word)
        dictionary.select { |word| word.start_with?(new_word) }
    end

    def losing_move?(dictionary, word)
        dictionary.include?(word)
    end
end