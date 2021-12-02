defmodule Dive do

  def sum(course) do
    {h, v} = calculate_coords(course)
    h * v
  end

  def calculate_coords(course) do
    h_moves = Enum.filter(course, fn {type, _} -> type in ["forward"] end)
    up_moves = Enum.filter(course, fn {type, _} -> type in ["up"] end)
    down_moves = Enum.filter(course, fn {type, _} -> type in ["down"] end)

    h_pos = Enum.reduce(h_moves, 0, fn {_, val}, acc -> acc + val end)
    up_sum = Enum.reduce(up_moves, 0, fn {_, val}, acc -> acc + val end)
    down_sum = Enum.reduce(down_moves, 0, fn {_, val}, acc -> acc + val end)

    {h_pos, down_sum - up_sum}
  end
end
