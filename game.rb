class Game
  attr_reader :board, :current_player, :players

  def initialize
    @board = Board.new
    @players = {
        white: Player.new(:white)
        red: Player.new(:red)
    }
    @current_player = :white
  end

  def play
    #The first player to lose all of his or her pieces loses the game.
    #If a player is put in a position where they cannot move, they lose.
    until board.all_pieces_taken?(current_player) || board.no_moves_available?(current_player)
      players[current_player].play_turn(board)
      @current_player = (current_player == :white) ? :red : :white
    end
    
    puts board.render
    # check if players have equal number of pieces. if so, who has more?
    if board.equal_no_pieces?(current_player)
      case board.num_of_kings(current_player) # returns true if current_player has more kings than other player
        when 1 # current_player has more kings
          puts "#{current_player} won!"
        when 0 # current_player has same number of kings as other player
          puts "Its a draw!"
        when -1 # other player has more kings than current player
          puts "#{current_player} lost!"
      end
    else
      puts "#{current_player} lost!"
    end
    # either the game ends in a draw or a win
    # If the players have the same amount of pieces, the player with the most kings wins.
    # If the players have an equal number of pieces and the same number of kings the game is a draw.

  end




end
