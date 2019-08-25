require_relative "piles"
require_relative "card"
require_relative "display"
require 'byebug'
class Board
    def self.all_cards
        all_cards = []

        Card.suits.each do |suit|
            next if suit == :blank
            Card.values.each do |value|
                next if value == :blank
                all_cards << Card.new(suit, value)
            end
        end
        (7).times {all_cards.shuffle!}
        all_cards
    end

    attr_accessor :tableau_pile, :foundation_pile, :freecell_pile, :grid, :empty_freecell_piles, :empty_tableau_piles
    def initialize(cards = Board.all_cards)
        populate_board(cards)
        @empty_freecell_piles = 4
        keep_track_of_empty_tableau_pile
    end

    def populate_board(cards)
        @grid = Array.new(2) { Array.new(8) }

        build_foundation_pile
        build_freecell_pile

        build_tableau_pile(cards)
    end

    def build_foundation_pile
        (0..3).each { |idx| self[[0, idx]] = FoundationPile.new(idx) }
    end

    def build_freecell_pile
        (0..3).each { |idx| self[[0, idx + 4]] = FreecellPile.new }
    end

    def build_tableau_pile(cards)
        (0..7).each do |idx|
            self[[1,idx]] = TableauPile.new
        end

        cards.each_with_index do |card, idx|
            self[[1,idx % 8]].add_card(card)
        end
    end

    def move_card(move_from, number_of_cards, move_to)
        move_from_pile = self[move_from]
        move_to_pile = self[move_to]
        moving_cards = move_from_pile.peak(number_of_cards)

        if move_to_pile.valid_move?(moving_cards)

            too_many_cards(number_of_cards)

            move_from_pile.remove(number_of_cards)
            move_to_pile.move(moving_cards)
            keep_track_of_empty_freecell_pile(move_from_pile, move_to_pile)
            keep_track_of_empty_tableau_pile
        end
    end

    def too_many_cards(number_of_cards)
        possible_number_of_cards = (empty_tableau_piles.downto(0).inject(&:+) + 1) * (empty_freecell_piles + 1)
        if number_of_cards > possible_number_of_cards
            raise "Does not have enough empty Freecell and Tablaeu piles to move"
        end
    end

    def keep_track_of_empty_tableau_pile
        @empty_tableau_piles = 0
        (0..7).each { |idx| self.empty_tableau_piles += 1 if self[[1, idx]].pile.empty? }
    end

    def keep_track_of_empty_freecell_pile(move_from_pile, move_to_pile)
        self.empty_freecell_piles += 1 if freecell_pile?(move_from_pile)
        self.empty_freecell_piles -= 1 if freecell_pile?(move_to_pile)
    end

    def freecell_pile?(pile)
        pile.is_a?(FreecellPile)
    end

    def won?
        empty_freecell_piles == 4 &&
        empty_tableau_piles == 8
    end

    def convert(pos)
        row, pile_loc = pos
        case row
        when 0
            return [0, pile_loc], 1
        when 1
            raise "Invalid pos"
        else
            pile = self[[1, pile_loc]].pile
            if pile.length <= row - 1
                return [1, pile_loc], 1
            else 
                num_card = pile.length - (row - 2)
                return [1, pile_loc], num_card
            end
        end
    end


    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, val)
        @grid[pos[0]][pos[1]] = val
    end
end

if __FILE__ == $PROGRAM_NAME
    # b = Board.new([Card.new(:spades, :ace)])
    b = Board.new

    until b.won?
        system("clear")
        display = Display.new(b)
        display.render
        begin
            move_from, move_to = nil, nil
            until move_from && move_to
            display.render
            # p b.empty_freecell_piles
            # p b.empty_tableau_piles
                if move_from
                    puts "Move to where? "
                    move_to = display.cursor.get_input
                    # display.reset! if move_to
                else
                    puts "Move from where? "
                    move_from = display.cursor.get_input
                    # display.reset! if move_from
                end
            end
            move_from_pos, num_card = b.convert(move_from)
            move_to_pos, _ = b.convert(move_to)
            # debugger
            b.move_card(move_from_pos, num_card, move_to_pos)
        rescue RuntimeError => e
            puts e.message
            puts "Enter valid position "
            sleep(2)
            retry
        end
    end
    system("clear")
    display.render
    puts "You've won!! Wow...You've got some serious patients"
end