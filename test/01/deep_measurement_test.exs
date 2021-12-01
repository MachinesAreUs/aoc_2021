defmodule DeepMeasurementTest do
  use ExUnit.Case

  setup do
    sample = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

    challenge =
      "./resources/01_measurements.txt"
      |> File.stream!()
      |> Stream.map(&to_int(&1))

    {:ok, sample_measurements: sample, challenge_measurements: challenge}
  end

  test "1st part. Sample is covered", %{sample_measurements: measurements} do
    assert DeepMeasurement.count_increases(measurements) == 7
  end

  test "1st part. AoC challenge", %{challenge_measurements: measurements} do
    assert DeepMeasurement.count_increases(measurements) == 1167
  end

  test "2nd part. Sample is covered", %{sample_measurements: measurements} do
    assert DeepMeasurement.count_window_increases(measurements) == 5
  end

  test "2nd part. AoC challenge", %{challenge_measurements: measurements} do
    assert DeepMeasurement.count_window_increases(measurements) == 1130
  end

  def to_int(str) do
    str |> String.trim() |> String.to_integer()
  end
end
