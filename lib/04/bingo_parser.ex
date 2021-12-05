defmodule BingoParser do
  @moduledoc false

  def parse(lines) do
    nums = get_nums(Enum.at(lines, 0))
    boards = get_boards(Enum.drop(lines, 1))
    [nums: nums, boards: boards]
  end

  def get_nums(line) do
    line
    |> String.split(",")
    |> Enum.map(fn str -> String.trim(str) |> String.to_integer() end)
  end

  def get_boards(lines) do
    lines
    |> Enum.chunk_every(6)
    |> Enum.map(&to_board/1)
  end

  def to_board(lines) do
    lines
    |> Enum.drop(1)
    |> Enum.map(&to_numbers/1)
  end

  def to_numbers(str) do
    str
    |> String.trim()
    |> String.split(~r/[[:space:]]+/)
    |> Enum.map(&String.to_integer/1)
  end
end
