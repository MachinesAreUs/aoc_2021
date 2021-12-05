defmodule GiantSquid do
  @moduledoc false

  # 1st part

  def bingo_winner(nums, boards) do
    solve(nums, to_marked_boards(boards))
  end

  def solve([h | t], boards) do
    new_boards = mark_boards(boards, h)
    winner = find_winner(new_boards)
    case winner do
      nil -> solve(t, new_boards)
      win -> score(h, win)
    end
  end

  def mark_boards(boards, n) do
    Enum.map(boards, fn b -> mark_board(b, n) end)
  end

  def mark_board(board, n) do
    Enum.map(board, fn row ->
      Enum.map(row, fn cell = {num, _} ->
        if num == n, do: {num, true}, else: cell
      end)
    end)
  end

  def find_winner(boards) do
    Enum.find(boards, fn board -> is_winner?(board) end)
  end

  def is_winner?(board) do
    winning_row? =
      Enum.any?(board, fn row ->
        Enum.all?(row, fn {_, marked} -> marked end)
      end)

    winning_col? =
      Enum.any?(transpose(board), fn col ->
        Enum.all?(col, fn {_, marked} -> marked end)
      end)

    winning_row? or winning_col?
  end

  def score(n, board) do
    unmarked_sum =
      board
      |> Enum.flat_map(fn row ->
        row
        |> Enum.reject(fn {_, mark} -> mark end)
        |> Enum.map(fn {num, _} -> num end)
      end)
      |> Enum.sum()
    n * unmarked_sum
  end

  def to_marked_boards(boards) do
    Enum.map(boards, fn board ->
      Enum.map(board, fn row ->
        Enum.map(row, fn num -> {num, false} end)
      end)
    end)
  end

  defp transpose(mtx), do: Enum.zip_with(mtx, &(&1))

  # 2nd part

  def last_winner(nums, boards) do
    solve2(nums, _winners = [], to_marked_boards(boards))
  end

  def solve2([], winners, _) do
    {last_winner, num} = Enum.at(winners, -1)
    score(num, last_winner)
  end

  def solve2([h | t], winners,  boards) do
    new_boards = mark_boards(boards, h)
    new_winners = find_all_winners(new_boards)
    case new_winners do
      [] -> solve2(t, winners, new_boards)
      _ ->
        rem_boards = new_boards -- new_winners
        new_winners = Enum.map(new_winners, fn win -> {win, h} end)
        solve2(t, winners ++ new_winners, rem_boards)
    end
  end

  def find_all_winners(boards) do
    Enum.filter(boards, fn board -> is_winner?(board) end)
  end
end
