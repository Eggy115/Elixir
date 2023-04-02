defmodule Battleships do
  def play do
    board_size = 5
    board = Enum.map(1..board_size, fn _ -> Enum.map(1..board_size, fn _ -> :O end) end)
    ships = Enum.map(1..3, fn _ -> {rand(1..board_size), rand(1..board_size)} end)
    num_turns = 0

    loop(board, ships, num_turns)
  end

  defp loop(board, ships, num_turns) do
    IO.puts("   " <> Enum.join(0..4, " "))
    Enum.each(board, fn (row, i) ->
      IO.write("#{i}  ")
      IO.puts(Enum.join(row, " "))
    end)
    IO.puts("")
    
    {guess_row, guess_col} = get_guess()
    
    case {guess_row, guess_col} in
      {x, y} when {x, y} in ships ->
        IO.puts("Congratulations! You sunk a ship!")
        board = set_board(board, guess_row, guess_col, :X)
        ships = Enum.reject(ships, &(&1 == {guess_row, guess_col}))
        if Enum.empty?(ships) do
          IO.puts("You win!")
          IO.puts("Turns: #{num_turns}")
          :ok
        else
          loop(board, ships, num_turns + 1)
        end
      {x, y} when x < 0 or x >= length(board) or y < 0 or y >= length(board) ->
        IO.puts("Oops, that's not even in the ocean.")
        loop(board, ships, num_turns + 1)
      {x, y} when board |> Enum.at(x) |> Enum.at(y) == :X ->
        IO.puts("You guessed that one already.")
        loop(board, ships, num_turns + 1)
      {x, y} ->
        IO.puts("You missed!")
        board = set_board(board, guess_row, guess_col, :-)
        loop(board, ships, num_turns + 1)
    end
  end

  defp get_guess do
    IO.puts("Guess Row: ")
    guess_row = IO.gets("") |> String.trim() |> String.to_integer()

    IO.puts("Guess Col: ")
    guess_col = IO.gets("") |> String.trim() |> String.to_integer()

    {guess_row, guess_col}
  end

  defp set_board(board, row, col, value) do
    Enum.map(board, fn (r, i) ->
      if i == row do
        Enum.map(r, fn (v, j) ->
          if j == col do
            value
          else
            v
          end
        end)
      else
        r
      end
    end)
  end
end

Battleships.play()
