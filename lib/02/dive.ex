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

  def corrected_sum(course) do
    {h_pos, depth, aim} = calculate_correct_coords(course)
    h_pos * depth
  end

  def calculate_correct_coords(course) do
    h_pos = depth = aim = 0
    Enum.reduce(course, {h_pos, depth, aim}, fn move, acc -> update_coords(move, acc) end)
  end

  defp update_coords({"down",    val}, {h_pos, depth, aim}), do: {h_pos, depth, aim + val}
  defp update_coords({"up",      val}, {h_pos, depth, aim}), do: {h_pos, depth, aim - val}
  defp update_coords({"forward", val}, {h_pos, depth, aim}) do
    new_h_pos = h_pos + val
    new_depth = depth + (aim * val)
    {new_h_pos, new_depth, aim}
  end
end
