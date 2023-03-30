class Player
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess(fragment)
        puts "Current fragment is: #{fragment}"
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