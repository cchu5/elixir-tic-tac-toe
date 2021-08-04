defmodule TicTacToeTest do
  import TestHelper
  use ExUnit.Case
  doctest TicTacToe

  describe "new_board tests: " do
    test "new_board exists" do
      assert function_exported?(TicTacToe, :new_board, 0) == true
    end

    test "create new board" do
      board = TicTacToe.new_board()
      assert board |> is_map == true

      expected_square = %Square{position: 1}
      assert board |> Enum.fetch(0) == {:ok, {expected_square, :empty}}
    end

    test "board should have 9 squares" do
      assert TicTacToe.new_board() |> Map.keys() |> length > 0
      assert TicTacToe.new_board() |> Map.keys() |> Enum.count() == 9
    end
  end

  describe "check_player tests: " do
    test "check_player exists" do
      assert function_exported?(TicTacToe, :check_player, 1) == true
    end

    test "player should be :o or :x" do
      assert TicTacToe.check_player(:o) == {:ok, :o}
      assert TicTacToe.check_player(:x) == {:ok, :x}
      assert TicTacToe.check_player(:z) == {:error, :invalid_player}
    end
  end

  describe "choose_square tests: " do
    test "choose_square exists" do
      assert function_exported?(TicTacToe, :choose_square, 3) == true
    end

    test "choose an empty square" do
      board = TicTacToe.new_board()
      square = %Square{position: 1}

      board = TicTacToe.choose_square(board, square, :o)

      assert {:ok, result} = board
      assert result |> Enum.fetch(0) == {:ok, {square, :o}}
    end

    test "choose a square that's been chosen" do
      board = TicTacToe.new_board()
      square = %Square{position: 1}
      {:ok, board} = TicTacToe.choose_square(board, square, :o)
      result = TicTacToe.choose_square(board, square, :x)

      assert {:error, :taken} = result
    end

    test "choose a nonexistent square" do
      board = TicTacToe.new_board()
      result = TicTacToe.choose_square(board, "", :o)

      assert {:error, :invalid_location} = result
    end
  end

  describe "play_at tests: " do
    test "play_at exists" do
      assert function_exported?(TicTacToe, :play_at, 3) == true
    end

    test "play_at returns a new_board" do
      board = TicTacToe.new_board()

      {:ok, expected_board} = TicTacToe.choose_square(board, %Square{position: 1}, :o)
      new_board = TicTacToe.play_at(board, 1, :o)

      assert new_board == expected_board
    end
  end

  describe "check_progress tests: " do
    test "check_progress exists" do
      assert function_exported?(TicTacToe, :check_progress, 1) == true
    end

    test "check_progress returns a new_board if there are no moves yet or only one move" do
      board = TicTacToe.new_board()
      {:ok, expected_board} = TicTacToe.choose_square(board, %Square{position: 1}, :o)
      {:ok, new_board} = TicTacToe.check_progress(expected_board)

      assert new_board == expected_board
    end

    test "check_progress returns the winner if a player wins" do
      board_o = create_populated_board([{1,:o}, {4,:x}, {2,:o}, {5,:x}, {3,:o}])
      board_x = create_populated_board([{1,:o}, {4,:x}, {2,:o}, {5,:x}, {6,:x}])
      assert {:ok, :winner_o} = TicTacToe.check_progress(board_o)
      assert {:ok, :winner_x} = TicTacToe.check_progress(board_x)
    end

    test "check_progress returns draw if no one wins and no more moves" do 
      board = create_populated_board([{1,:o}, {2,:x}, {3,:o}, {4,:o}, {5,:x}, {6,:o}, {7,:x}, {8,:o}, {9,:x}])

      assert {:ok, :draw} = TicTacToe.check_progress(board) 
    end
  end

  describe "all_spaces_taken tests: " do
    test "all_spaces_taken exists" do
      assert function_exported?(TicTacToe, :all_spaces_taken, 1) == true
    end

    test "all_spaces_taken returns true if there is 1 space or less left that are :empty" do
      expected = create_populated_board([{1,:o}, {2,:x}, {3,:o}, {4,:o}, {5,:x}, {6,:o}, {7,:x}, {8,:o}])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
        |> TicTacToe.all_spaces_taken
      
      assert expected == true
    end

    test "all_spaces_taken returns false if there is more than 1 space that is :empty" do
      expected = create_populated_board([{1,:o}, {2,:x}, {3,:o}, {4,:o}, {5,:x}, {6,:o}])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
        |> TicTacToe.all_spaces_taken
      
      assert expected == false
    end
  end
  
  describe "three_in_a_row tests: " do
    test "three_in_a_row exists" do
      assert function_exported?(TicTacToe, :three_in_a_row, 3) == true
    end

    test "three_in_a_row returns true for horizontal win" do 
      mapped_board_for_o_win = 
        create_populated_board([{1,:o}, {2,:o}, {3,:o}, {4,:x}, {5,:x}]) 
        |> Enum.map(fn {square, value} -> {square.position, value} end) 
        |> Map.new
      mapped_board_for_x_win = 
        create_populated_board([{1,:o}, {2,:o}, {4,:x}, {5,:x}, {6,:x}]) 
        |> Enum.map(fn {square, value} -> {square.position, value} end) 
        |> Map.new 
      positions_o = [1, 2, 3]
      positions_x = [4, 5, 6]
 
      assert TicTacToe.three_in_a_row(mapped_board_for_o_win, positions_o, :o) == true
      assert TicTacToe.three_in_a_row(mapped_board_for_x_win, positions_x, :x) == true
    end
    
    test "three_in_a_row returns true for vertical win" do
      mapped_board_for_o_win =
        create_populated_board([{1,:o}, {2,:x}, {4,:o}, {3,:x}, {7,:o}])
        |> Enum.map(fn {square, value} -> {square.position, value} end) 
        |> Map.new
      mapped_board_for_x_win =
        create_populated_board([{2,:x}, {1,:o}, {5,:x}, {3,:o}, {8,:x}])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
      positions_o = [1,4,7]
      positions_x = [2,5,8]
      
      assert TicTacToe.three_in_a_row(mapped_board_for_o_win, positions_o, :o) == true
      assert TicTacToe.three_in_a_row(mapped_board_for_x_win, positions_x, :x) == true
    end

    test "three_in_a_row returns true for diagonal win" do
      mapped_board_for_o_win =
        create_populated_board([{1,:o}, {2,:x}, {5,:o}, {3,:x}, {9,:o}])
        |> Enum.map(fn {square, value} -> {square.position, value} end) 
        |> Map.new 
      mapped_board_for_x_win =
        create_populated_board([{3,:x}, {1,:o}, {5,:x}, {1,:o}, {7,:x}])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
      positions_o = [1,5,9]
      positions_x = [3,5,7]
       
      assert TicTacToe.three_in_a_row(mapped_board_for_o_win, positions_o, :o) == true
      assert TicTacToe.three_in_a_row(mapped_board_for_x_win, positions_x, :x) == true
    end
    
    test "three_in_a_row returns false for no winners" do
      expected = create_populated_board([{1,:o},{2,:x}])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
        |> TicTacToe.three_in_a_row([1,2,3], :o)

      assert expected == false 
    end 
  end

  describe "made_a_move tests: " do
    test "made_a_move exists" do
      assert function_exported?(TicTacToe, :made_a_move, 2) == true
    end

    test "made_a_move returns false if player has not made a move" do
      expected_o = create_populated_board([])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
        |> TicTacToe.made_a_move(:o)
      expected_x = create_populated_board([])
        |> Enum.map(fn {square, value} -> {square.position, value} end)
        |> Map.new
        |> TicTacToe.made_a_move(:x)

      assert expected_o == false
      assert expected_x == false
    end 
  end
end
