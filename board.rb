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
    #
    jumped_pieces
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

  def move_type(from_pos, *to_pos)
    from_row, from_col = from_pos
    to_row, to_col = to_pos.first

    row_change = (to_row - from_row).abs
    col_change = (to_col - from_col).abs

    change = [row_change, col_change]

    change == [1,1]  ? :SLIDE : :JUMP
  end

  def perform_slide(color, from_pos, move_type)
    #if piece is white and is a man row is 1 direction
    #if piece is red and is a man, row direction is -1 direction
    row_dir = (color == :white) ? 1 : -1
    move_change = (move_type == :JUMP) ? JUMP_MOVE : SLIDE_MOVE

    possible_moves = [] #there are only two...if any
    row, col = from_pos

    ### THIS DOES NOT YET CHECK IF MOVE IS ON THE BOARD ###
    # if man
    possible_moves[0] = [row + row_dir * move_change[0], col + move_change[1]] # right
    possible_moves[1] = [row + row_dir * move_change[0], col - move_change[1]] # left

    if  self[from_pos].status == :king     # if king
      possible_moves[2] = [row - row_dir * move_change[0], col + move_change[1]] # right
      possible_moves[3] = [row - row_dir * move_change[0], col - move_change[1]] # left
    end

    possible_moves
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
