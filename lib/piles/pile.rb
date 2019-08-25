class Pile
    attr_reader :pile

    def initialize(cards)
        @pile = cards
    end

    def [](pos)
        @pile[pos]
    end

    def []=(pos,val)
        @pile[pos] = val
    end

    def peak(n)
        @pile[suit][-n..-1]
    end

    def remove(number_of_cards)
        @pile[suit].pop(number_of_cards)
    end

    def move(moving_cards)
        @pile[suit] += moving_cards
    end
end