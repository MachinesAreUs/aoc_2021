defmodule Lanternfish do
  @moduledoc false

  def calculate_fish(fishes, 0) do
    length(fishes)
  end

  def calculate_fish(fishes, days) do
    IO.puts "pid: #{inspect(self())}. days: #{days}"

    {updated, new} =
      Enum.map_reduce(fishes, [], fn f, acc ->
        case f do
          0 -> {6, [8 | acc]}
          _ -> {f - 1, acc}
        end
      end)
    calculate_fish(updated ++ new, days - 1)
  end
end
