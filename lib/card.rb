require "colorize"
# -*- coding: utf-8 -*-

# Represents a playing card.
class Card
  SUIT_STRINGS = {
    :blank    => " ",
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :blank => " ",
    :ace   => "A",
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K"
  }

  CARD_VALUE = {
    :blank => 0,
    :ace   => 1,
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13
  }

  # Returns an array of all suits.
  def self.suits
    SUIT_STRINGS.keys
  end

  # Returns an array of all values.
  def self.values
    VALUE_STRINGS.keys
  end

  attr_reader :suit, :value
  

  def initialize(suit, value)
    unless Card.suits.include?(suit) and Card.values.include?(value)
      raise "illegal suit (#{suit}) or value (#{value})"
    end

    @suit, @value = suit, value
  end

  def color
    case suit
    when :spades, :clubs
      return :black
    else
      return :red
    end
  end

  def card_value
    CARD_VALUE[value]
  end

  # Compares two cards to see if they're equal in suit & value.
  def ==(other_card)
    return false if other_card.nil?

    [:suit, :value].all? do |attr|
      self.send(attr) == other_card.send(attr)
    end
  end

  def to_s
    card_value = VALUE_STRINGS[value]
    card_suit = SUIT_STRINGS[suit]
    card_string = card_value == "10" ? 
      " #{card_value + card_suit} ": 
      "  #{card_value + card_suit} "
    
    card_string.colorize(:color => color, :background => :white)
  end
end
