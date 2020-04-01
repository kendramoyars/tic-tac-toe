module TicTacToe

  class Player

    attr_reader :name, :symbol
  
    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end

  end

  class Board
    
    attr_accessor :cells
    
    def initialize
      @cells = (1..9).to_a
    end

    def print_board
      br = "---+---+---"
      puts ""
      puts " #{cells[0]} | #{cells[1]} | #{cells[2]}"
      puts br
      puts " #{cells[3]} | #{cells[4]} | #{cells[5]}"
      puts br
      puts " #{cells[6]} | #{cells[7]} | #{cells[8]}"
      puts ""
    end

  end

  class Game
    attr_accessor :turn, :board, :current_player, :move
    attr_reader :player_one, :player_two

    def initialize
      @player_one = Player.new("Player 1", "X")
      @player_two = Player.new("Player 2", "O")
      @board = Board.new
      @turn = 1
      @current_player = ""
      @move = ""
    end

    def play 
      puts "Tic-Tac-Toe!"
      puts ""
      puts "Player 1 will be X and Player 2 will be O"
      play_turn
    end

    def play_turn
      board.print_board
      if (turn % 2 == 1)
        self.current_player = player_one
      else
        self.current_player = player_two
      end

      print "#{current_player.name}, choose a number to place your #{current_player.symbol}: "
      self.move = gets.chomp.to_i
      verify_move
    end

    def verify_move
      if board.cells[move-1] == move
        self.board.cells[move-1] = "#{current_player.symbol}"
        self.turn += 1
        check_game_over
      else
        puts "Sorry but that doesn't work. Try another number!"
        play_turn
      end
    end

    def check_game_over
      win_combos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
      win_combos.each do |combo|
        count = 0
        combo.each do |num|
          count += 1 if board.cells[num] == current_player.symbol
        end

        if count == 3
          board.print_board
          puts "#{current_player.name} wins!!!"
          exit
        end
      end
      if turn == 10
        board.print_board
        puts "It's a tie!!!"
      else
        play_turn
      end
    end

  end

  game = Game.new.play
  
end