require "colorize"
require_relative "cursor"

class Display

  attr_reader :board, :notifications, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @notifications = {}
  end


  def create_grid
    first_row = []
    board[[0,0..-1]].each do |pile|
      card = pile.pile.values[0][-1]
      first_row << (card.nil? ? Card.new(:blank, :blank) : card)
    end
    second_row = ["------" * 9]
    end_of_tallest_pile = false
    counter = 0
    rows = []
    until end_of_tallest_pile
        end_of_tallest_pile = true
        line = []
        (0..7).each do |idx|
            card = board[[1,idx]][counter]
            end_of_tallest_pile = false  if !card.nil?
            line << (card.nil? ? Card.new(:blank, :blank) : card)
        end
        counter += 1
        rows << line
    end       
    [first_row] + [second_row] + rows
  end

  # def reset!
  #   @notifications.delete(:error)
  # end

  # def uncheck!
  #   @notifications.delete(:check)
  # end

  # def set_check!
  #   @notifications[:check] = "Check!"
  # end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    create_grid.each_with_index do |rows, i|
      rows.each_with_index do |card, j|
        cursor_position = cursor.cursor_pos
        if cursor_position[0] == 1 && i == 1
          print "|#{card.to_s.colorize(:background => :green)}|"
        elsif cursor_position == [i, j] 
          print "|#{card.to_s.colorize(:background => :green)}|"
        else
          print "|#{card}|"
        end
      end
      puts
    end
  end

end
