# Phase 1: Playing a Single Round
require 'set'
require_relative 'player'

class Game
    attr_reader :fragment
    ALPHABET = ('a'..'z').to_set

    def initialize(*players)
        @players = players
        @dictionary = Set.new(File.readlines('dictionary.txt').map(&:chomp))
    end
    
    def play_round
        @fragment = ''

        until round_over?(fragment)
            take_turn
            next_player!
        end
        
        puts "#{current_player.name} wins" 
    end

    def round_over?(fragment)
        @dictionary.include?(fragment)
    end

    def current_player
        @players.first
    end

    def previous_player
        @players[1]
    end

    def next_player!
        @players.rotate!
    end

    def take_turn
        letter = current_player.guess(fragment)

        while !valid_play?(letter)
            current_player.alert_invalid_guess(letter)
            letter = current_player.guess(fragment)
        end

        @fragment += letter
    end 

    def valid_play?(letter)
        return false unless ALPHABET.include?(letter)
        @dictionary.any? { |word| word.start_with?(fragment + letter) }
    end
end

if __FILE__ == $PROGRAM_NAME
    g = Game.new(Player.new('hao'), Player.new('min'))
    g.play_round
end