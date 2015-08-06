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

  def initialize(fill_board = true) #also let pieces populate board themselves
    make_grid(fill_board)
  end

  def fill_rows(color)
    position_list = (color == :white) ? WHITE_SPOT : RED_SPOTS

    position_list.each do |position|
      piece_class.new(color,self, position)
    end
  end

  def move_piece(turn_color, from_pos, *to_pos)
    # perform checks


    move_piece!(from_pos, to_pos.last)
    jumped_pieces = find_jumped_pieces
    remove_pieces!(*jumped_pieces)
  end

  def find_jumped_pieces
  end

  def remove_pieces!(*jumped_pieces)
    jumped_pieces.each{ |jumped_piece_pos| self[jumped_piece_pos] = nil}
  end


  def move_piece!(from_pos, *to_pos)

    piece = self[from_pos]

    self[to_pos] = piece
    self[from_pos] = nil
    piece.pos = to_pos
    piece_status()

  end

  def perform_slide


  end
  def perform_jump


  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def make_grid(fill_board)
    @rows  Array.new(8) {Array.new(8)}
    return unless fill_board
    [:white, :red].each do |color|
      fill_rows(color)
    end
  end

end
