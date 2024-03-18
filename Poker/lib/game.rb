require_relative 'errors'
require_relative 'deck'
require_relative 'player'

class Game
    attr_accessor :deck, :current_players, :current_pot, :current_bet

    def initialize(names)
        raise TooManyPlayersError if names.length > 6
        raise NotEnoughPlayersError if names.length < 2
        set_up_poker_game(names)
    end

    def play
        welcome_message

        if play_one_round != "gameover"
            players_discard_cards
            play_one_round  
        end

        show_winners_info
    end

private
    def welcome_message
        puts "Welcome to poker game!\nInitial $$$ to start the game is $10. Updating players's bankrolls...\n\n"
    end

    def play_one_round
        current_players.length.times do
            get_move_and_next_turn
            return "gameover" if everyone_folded?
        end
        
        @current_bet = 0
    end

    def players_discard_cards
        current_players.each do |player| 
            draw_cards(player.discard_cards).each { |card| player.hand.hand_values[card.val] += 1 }
            player.print_cards_on_hand
        end
    end

    def show_winners_info
        current_players.each { |player| puts "#{player.name} - #{player.hand.identity} - #{player.hand.hand_values} - #{player.hand.val_to_suit}" }
        puts "Winners are: #{players_showdown}"
    end

    def get_move_and_next_turn
        puts "Current pot: $#{current_pot}\n\n"
        puts "It's #{current_players.first.name} turn"
        get_move
        next_turn!
    end

    def get_move
        cmd, amt = current_players.first.next_move
        update_poker_game(cmd, amt)
    end

    def set_up_poker_game(names)
        @deck = Deck.new
        @current_players = draw_cards_for_players(names)
        @current_pot = current_players.length * 10
        @current_bet = 0
        update_bankrolls(current_players.length, 10)
    end

    def update_bankrolls(n, amt)
        raise TooManyPlayersError if n > current_players.length
        (0...n).each { |i| current_players[i].bankroll -= amt }
    end

    def next_turn!
        @current_players.rotate!
    end

    def draw_cards_for_players(names)
        (1..names.length).map { Player.new(names.shift, draw_cards(5)) }
    end

    def get_deck
        deck.deck
    end

    def draw_cards(n)
        (1..n).map { get_deck.pop }
    end

    def update_poker_game(cmd, amt)
        update_current_player(cmd)
        update_current_bet(cmd, amt)
        update_bankrolls(1, amt)
        update_current_pot(amt)
        clear_table
    end

    def clear_table
        system('clear')
    end

    def update_current_pot(amt)
        @current_pot += amt
    end

    def update_current_bet(cmd, amt)
        @current_bet = amt if cmd == 'r' || (cmd == 'c' && current_bet == 0)        
    end

    def update_current_player(cmd)
        @current_players.shift if cmd == 'f'
    end

    def everyone_folded?
        current_players.length < 2
    end

    def players_showdown
        winner = [current_players.first]

        current_players[1..-1].each do |player|
            result = winner.first.hand.compare(player.hand)
            winner << player if result == 0                
            winner = [player] if result == -1
        end

        winner.map(&:name)
    end
end

if $PROGRAM_NAME == __FILE__
    Game.new(["Hao", "Min"]).play
end