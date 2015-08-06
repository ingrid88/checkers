class Piece

  SLIDE_MOVE = [1,1] # [1,-1], [-1,1],[-1,-1]
  JUMP_MOVE = [2,2] # [2,-2], [-2,2],[-2,-2]

  attr_reader :board, :color
  attr_accessor :pos, :status

  def initialize(color, board, pos, status = :man)
    @color, @board, @pos, @status = color, board, pos, status
    # status can be man or king
    board.add_piece(self, pos)
  end

  def perform_slide
    #

  end

  def perform_jump
  end



end
