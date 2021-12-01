defmodule DeepMeasurement do
  @moduledoc false

  @absurdly_deep 1_000_000_000_000

  def count_increases(measurements) do
    {_, increases} =
      Enum.reduce(measurements, {@absurdly_deep, 0}, fn m, {prev, count} ->
        if m > prev, do: {m, count + 1}, else: {m, count}
      end)
    increases
  end

  def count_window_increases(measurements) do
    m1 = measurements
    m2 = Stream.drop(measurements, 1)
    m3 = Stream.drop(measurements, 2)
    sums = Stream.zip_with([m1, m2, m3], fn [a, b, c] -> a + b + c end)
    count_increases(sums)
  end
end
