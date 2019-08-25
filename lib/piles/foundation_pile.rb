require_relative "pile"
class FoundationPile < Pile
    attr_reader :suit

    FOUNDATION_PILE = {
        0 => :spades,
        1 => :hearts,
        2 => :clubs,
        3 => :diamonds
    }
    
    def initialize(idx)
        @suit = FOUNDATION_PILE[idx]
        @pile = Hash.new { |h,k| h[k] = [] }
        @pile[suit] = [Card.new(suit, :blank)]
    end

    def valid_move?(moving_cards)
        raise "Can't move more than one card to Foundation pile" if moving_cards.length != 1
        cards = pile.values[-1] + moving_cards
        valid_combining_card?(cards)
    end

    def valid_combining_card?(cards)
        same_suit?(cards) && continuous_values?(cards)
    end

    def same_suit?(cards)
        if cards.all? { |card| suit == card.suit }
            true
        else
            raise "Not the same suit"
        end
    end

    def continuous_values?(cards)
        if (0...cards.length-1).all? { |idx| cards[idx].card_value + 1 == cards[idx + 1].card_value} 
            true
        else
            raise "Not concsecutive value"
        end
    end

    def remove(number_of_cards)
        raise "Cannot remove cards from Foundation Pile"
    end
end