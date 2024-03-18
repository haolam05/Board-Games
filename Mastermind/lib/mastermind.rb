require_relative "code"

class Mastermind
    #PART III
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(code_instance)
        puts "exact matchees: #{@secret_code.num_exact_matches(code_instance)}"
        puts "near matches: #{@secret_code.num_near_matches(code_instance)}"
    end

    def ask_user_for_guess
        puts 'Enter a code'
        guessed_code = Code.from_string(gets.chomp)
        print_matches(guessed_code)
        @secret_code == guessed_code
    end
end
