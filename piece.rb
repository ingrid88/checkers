class Piece

  SLIDE = 1
  JUMP = 2

  attr_reader :board, :color
  attr_accessor :pos, :status

  def initialize(color, board, pos, status = :man)
    @color, @board, @pos, @status = color, board, pos, status
    # status can be man or king
    board.add_piece(self, pos)
  end

  def move!(to_pos)
    board[self.pos] = nil
    self.pos = to_pos
    board[to_pos] = self
  end

  def render
    symbols[color]
  end

  def symbols
    { white: '$ ', red: '& ' }
  end

  def king?
    self.status == :king
  end

  def directions
    #if piece is white and is a man row is 1 direction
    #if piece is red and is a man, row direction is -1 direction
    row_dir = (color == :white) ? 1 : -1

    mov_right = [ row_dir, 1 ]
    mov_left = [ row_dir, -1 ]

    dir = king? ? [mov_left.abs] : [mov_left, mov_right]
  end

  def change(to_pos)
    from_row, from_col = self.pos
    to_row, to_col = to_pos

    row_change = (to_row - from_row)
    col_change = (to_col - from_col)

    change = king? ? [row_change.abs, col_change.abs] : [row_change, col_change]
  end

  def valid_slide?(to_pos)
    if empty_spot?(to_pos) && directions.any?{ |dir| dir == change(to_pos)}
      move!(to_pos)
      return true
    end
    return false
  end

  def empty_spot?(to_pos)
    board[to_pos].nil?
  end

  def valid_jump?(to_pos)
    dx, dy = direction
    dx = dx * 2
    p "change : #{change}"
    if empty_spot?(to_pos)
    # if man
      if (change == [2 * row_dir , 2 ] || change == [ 1 * row_dir , -1 ])
        move!(to_pos)
        return true
      # if king
    elsif king && (change == [-1 * row_dir , 1] || change == [-1 * row_dir ,-1])
        move!(to_pos)
        return true
      end

    end
    return false
  end

  # def jump?(next)
  # end

  def find_jumped_pieces
  end

  def remove_pieces!(*jumped_pieces)
    jumped_pieces.each{ |jumped_piece_pos| self[jumped_piece_pos] = nil}
  end


    # delegates to perform_slide and perform_jump
  # def perform_move?(*to_pos)
  #   from_row, from_col = self.pos
  #   to_row, to_col = to_pos.first
  #
  #   row_change = (to_row - from_row).abs
  #   col_change = (to_col - from_col).abs
  #   change = [row_change, col_change]
  #   if change == [1,1]
  #     perform_slide(to_pos.first)
  #   elsif change ==[2,2]
  #     perform_jump(*to_pos)
  #   else
  #     return false
  #   end
  #     return true
  # end
  #
  #
  # def perform_jump?(*to_pos)
  #
  #   to_pos.each |next_pos|
  #     if valid_jump?(next_pos)
  #       jump(next_pos)
  #       jumped_pieces = find_jumped_pieces
  #       remove_pieces!(*jumped_pieces)
  #     end
  #
  # end
  #
  # def jump()
  # end
  # def find_jumped_pieces
  # end
  #
  # def valid_jump?
  # end
  #
  # def remove_pieces!(*jumped_pieces)
  #   jumped_pieces.each{ |jumped_piece_pos| self[jumped_piece_pos] = nil}
  # end
  #
  # def move_piece!(from_pos, *to_pos)
  #
  #   piece = self[from_pos]
  #
  #   self[to_pos] = piece
  #   self[from_pos] = nil
  #   piece.pos = to_pos
  #   piece_status()
  # end
  #

  # def move(color, pos)
  #   #if piece is white and is a man row is 1 direction
  #   #if piece is red and is a man, row direction is -1 direction
  #   row_dir = (color == :white) ? 1 : -1
  #   move_change = (move_type == :JUMP) ? JUMP_MOVE : SLIDE_MOVE
  #
  #   possible_moves = [] #there are only two...if any
  #   row, col = from_pos
  #
  #   ### THIS DOES NOT YET CHECK IF MOVE IS ON THE BOARD ###
  #   # if man
  #   possible_moves[0] = [row + row_dir * move_change[0], col + move_change[1]] # right
  #   possible_moves[1] = [row + row_dir * move_change[0], col - move_change[1]] # left
  #
  #   if  self[from_pos].status == :king     # if king
  #     possible_moves[2] = [row - row_dir * move_change[0], col + move_change[1]] # right
  #     possible_moves[3] = [row - row_dir * move_change[0], col - move_change[1]] # left
  #   end
  #
  #   on_board_moves(possible_moves)
  # end
  #
  # def on_board_moves(possible_moves)
  #
  #   valid_moves = possible_moves.select do |move|
  #
  #   end
  #
  #   valid_moves
  # end
  #
  #
  #
  # def on_board?(possible_moves)
  #
  # end

end
