require_relative 'piece'

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

  def initialize #also let pieces populate board themselves
    @grid = Array.new(8) {Array.new(8)}
    [:white, :red].each do |color|
      fill_grid(color)
    end
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

  def move_piece(turn_color, from_pos, *to_pos)
    # perform checks
    piece = self[from_pos]
    piece.perform_slide(*to_pos)
    piece.perform_jump(*to_pos)

    # move_piece!(from_pos, to_pos.last)
    # jumped_pieces = find_jumped_pieces
    # remove_pieces!(*jumped_pieces)
  end

end
