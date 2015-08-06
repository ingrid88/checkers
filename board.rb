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
    
    # red pieces go in
    # white pieces go
  end

  def make_grid(fill_board)
    @rows  Array.new(8) {Array.new(8)}
    return unless fill_board
    [:white, :red].each do |color|
      fill_rows(color)
    end
  end

end
