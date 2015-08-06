class Piece
  attr_reader :board, :color
  attr_accessor :pos, :status

  def initialize(color, board, pos, status = :man)
    @color, @board, @pos, @status = color, board, pos, status
    # status can be man or king
    board.add_piece(self, pos)
  end



end
