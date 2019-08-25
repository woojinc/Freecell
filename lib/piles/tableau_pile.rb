require_relative "pile"
class TableauPile < Pile
    TABLEAU_PILE = {
        0 => 7,
        1 => 7,
        2 => 7,
        3 => 7,
        4 => 6,
        5 => 6,
        6 => 6,
        7 => 6
    }
    def initialize
        @pile = Array.new
    end

    def add_card(card)
        @pile += [card]
    end

    def valid_move?(moving_cards)
        cards = [self[-1]] + moving_cards
        valid_combining_card?(cards)
    end

    def valid_combining_card?(cards)
        alternating_suits?(cards) && continuous_values?(cards)
    end

    def alternating_suits?(cards)
        if (0...cards.length-1).all? { |idx| cards[idx].color != cards[idx + 1].color }
            true
        else
            raise "Incorrect suits"
        end
    end

    def continuous_values?(cards)
        if (0...cards.length-1).all? { |idx| cards[idx].card_value == cards[idx + 1].card_value + 1 }
            true
        else
            raise "Incorrect values"
        end
    end

    def possible_logistics?(cards)

    end

    def remove(number_of_cards)
        @pile.pop(number_of_cards)
    end

    def move(moving_cards)
        @pile += moving_cards
    end

    def peak(n)
        @pile[-n..-1]
    end


end