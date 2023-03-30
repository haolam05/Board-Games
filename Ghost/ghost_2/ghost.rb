# Phase 2: Playing a Full Game
require 'set'
require_relative 'player'

class Game
    attr_reader :fragment
    ALPHABET = ('a'..'z').to_set

    def initialize(*players)
        @players = players
        @dictionary = Set.new(File.readlines('dictionary.txt').map(&:chomp))
        @losses = Hash.new { |losses, player| losses[player] = 0 }
    end
    
    def play_round
        display_standings
        @fragment = ''

        until round_over?(fragment)
            take_turn
            next_player!
        end
        
        @losses[previous_player] += 1
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

    def record(player)
        'GHOST'[0...@losses[player]]
    end

    def display_standings
        @players.each { |player| puts "#{player.name}: #{record(player)}"  }
    end

    def game_over?
        @losses.values.include?(5)
    end

    def run
        play_round until game_over?
        puts "#{current_player.name} wins" 
    end
end

if __FILE__ == $PROGRAM_NAME
    g = Game.new(Player.new('hao'), Player.new('min'))
    g.run
end