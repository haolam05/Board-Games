# Phase 3: Multiplayer!
require 'set'
require_relative 'player'

class Game
    ALPHABET = ('a'..'z').to_set
    LOSS_COUNT = 5

    def initialize(*players)
        @players = players
        @dictionary = Set.new(File.readlines('dictionary.txt').map(&:chomp))
        @losses = Hash.new { |losses, player| losses[player] = 0 }
    end

    def run
        play_round until game_over?
        puts "#{current_player.name} wins!" 
    end
    
    private 
    attr_reader :fragment

    def play_round
        welcome
        @fragment = ''

        until round_over?(fragment)
            take_turn
            next_player!
        end
        
        update_standings 
    end

    def round_over?(fragment)
        @dictionary.include?(fragment)
    end

    def current_player
        @players.first
    end

    def previous_player     # find previous player by checking valid previous player
        (1...@players.length).each { |i| return prev_player(i) if @losses[prev_player(i)] < LOSS_COUNT }
    end

    def prev_player(i)      # previous player
        @players[@players.index(current_player) - i]
    end

    def next_player!
        @players.rotate! unless @losses[@players.rotate!.first] < LOSS_COUNT
    end

    def take_turn
        system('clear')
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
        puts "Current standings:"
        @players.each { |player| puts "#{player.name}: #{record(player)}"  }
        sleep(1)
    end

    def update_standings
        puts "#{previous_player.name} spelled '#{fragment}'."
        puts "#{previous_player.name} gets a letter!"
        puts "#{previous_player.name} has been eliminated!" if @losses[previous_player] == LOSS_COUNT - 1
        @losses[previous_player] += 1 
        sleep(3)
    end

    def game_over?
        remaining_players == 1    
    end

    def remaining_players
        @losses.values.count { |score| score < LOSS_COUNT }
    end

    def welcome
        system('clear')
        puts "Let's play a round of Ghost!"
        display_standings
    end
end

if __FILE__ == $PROGRAM_NAME
    g = Game.new(Player.new('Hao'), Player.new('Cat'), Player.new('Huy'))
    g.run
end