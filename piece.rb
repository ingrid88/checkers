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

  def diff_color?(pos)
    if board[pos].nil?
      return false
    elsif board[pos].color != self.color
      return true
    else
      return false
    end
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

    changes = [row_change, col_change]
  end

  def valid_change(to_pos)
    row_change, col_change = change(to_pos)

    changes = king? ? [row_change.abs, col_change.abs] : [row_change, col_change]
  end

  def valid_slide?(to_pos)
    if empty_spot?(to_pos) && directions.any?{ |dir| dir == valid_change(to_pos)}
      move!(to_pos)
      return true
    end
    return false
  end

  def empty_spot?(to_pos)
    board[to_pos].nil?
  end

  def valid_jump?(to_pos)
    dx, dy = directions
    dx, dy = dx * JUMP, dy * JUMP
    new_direction = [dx,dy]

    valid_dir = directions.any?{ |dir| dir == valid_change(to_pos)}
    free_spot = empty_spot?(to_pos)

    if free_spot && valid_dir && piece_jumped?(to_pos)
      move!(to_pos)
      remove!(to_pos)
      return true
    end
    return false
  end



  # def jump?(next)
  # end
  def jumped(to_pos)
    dx, dy = change(to_pos)
    dx, dy = dx / 2, dy / 2
    x, y   = self.pos

    jumped_x, jumped_y = dx + x, dy + y
    jumped_piece_pos = [jumped_x, jumped_y]
  end

  def piece_jumped?(to_pos)
    jumped_x, jumped_y = jumped(to_pos)

    if board[to_pos].nil? && diff_color?([jumped_x,jumped_y]) && !board[[jumped_x,jumped_y]].nil?
      return true
    else
      return false
    end

  end

  def remove!(to_pos)
    x, y   = jumped(to_pos)
    board[[jumped_x, jumped_y]] = nil
  end


end
