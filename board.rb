require_relative 'piece'
require 'colorize'

class Board
  WHITE_SPOT = [
    [0,1], [0,3], [0,5], [0,7],
    [1,0], [1,2], [1,4], [1,6],
    [2,1], [2,3], [2,5], [2,7]
  ]

  RED_SPOTS = [
    [5,0], [5,2], [5,4], [5,6],
    [6,1], [6,3], [6,5], [6,7],
    [7,0], [7,2], [7,4], [7,6],
  ]

  SIZE = 8

  SLIDE_MOVE = [1,1] # [1,-1], [-1,1],[-1,-1]
  JUMP_MOVE = [2,2] # [2,-2], [-2,2],[-2,-2]

  attr_reader :grid

  def initialize(fill_board = true) #also let pieces populate board themselves
    @grid = Array.new(8) {Array.new(8)}
    if fill_board
      [:white, :red].each do |color|
        fill_grid(color)
      end
    end
  end

  def board_dup
    board_copy = Board.new(false)
    pieces.each do |piece|
      piece.new(piece.color, board_copy, piece.pos, piece.status)
    end
  end

  def pieces
     grid.flatten.compact
  end


  def fill_grid(color)
    position_list = (color == :white) ? WHITE_SPOT : RED_SPOTS

    position_list.each do |position|
      Piece.new(color,self, position)
      puts "#{position}"
    end
  end

  def [](from_pos)
    row, col = from_pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def display
    list = [0,1,2,3,4,5,6,7]
    print "  0 1 2 3 4 5 6 7 \n"
    (0...SIZE).each do |row|
      print "#{list[row]} "
      (0...SIZE).each do |col|
        color = (col.odd? && row.odd?) || (col.even? && row.even?) ? :blue : :red
        if self[[row,col]].nil?
          print "  ".colorize(:background => color)
         else
          print self[[row,col]].render.colorize(:background => color)
         end
      end
      print "\n"
    end
  end

  def move_piece(turn_color, from_pos, *to_pos)
    # perform checks
    piece = self[from_pos]
    piece.perform_move(*to_pos)

    # move_piece!(from_pos, to_pos.last)
    # jumped_pieces = find_jumped_pieces
    # remove_pieces!(*jumped_pieces)
  end

end
