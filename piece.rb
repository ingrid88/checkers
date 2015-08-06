class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
    board.add_piece(self, pos)
  end

  

end
