require_relative "pile"
class FreecellPile < Pile
    attr_reader :suit
    FREECELL_PILE = {
        0 => 1,
        1 => 1,
        2 => 1,
        3 => 1,
    }    

    def initialize
        @pile = Hash.new { |h,k| h[k] = [] }
        @suit = :blank
        @pile[suit] = [Card.new(:blank, :blank)]
        # Pile.freecell_pile.each { |pile_num| @pile[pile_num] = [] }
    end

    def valid_move?(moving_cards)
        raise "Can't move more than one card to Freecell pile" if moving_cards.length != 1
        pile_empty?
    end

    def pile_empty?
        if @pile[suit][-1].suit == :blank && @pile[suit][-1].value == :blank
            true
        else
            raise "Freecell pile not empty"
        end
    end
end