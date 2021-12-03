defmodule DiveTest do
  use ExUnit.Case

  setup do
    sample =
      [
        {"forward", 5},
        {"down", 5},
        {"forward", 8},
        {"up", 3},
        {"down", 8},
        {"forward", 2}
      ]

    challenge =
      "./resources/02_course.txt"
      |> File.stream!()
      |> Stream.map(fn str ->
        [type, val_str] = String.split(str)
        {val, _} = Integer.parse(val_str)
        {type, val}
      end)

    {:ok, sample: sample, challenge: challenge}
  end

  test "1st part. Sample input", %{sample: input} do
    assert Dive.sum(input) == 150
  end

  test "1st part. AoC challenge", %{challenge: input} do
    assert Dive.sum(input) == 1451208
  end

  test "2nd part. Sample input", %{sample: input} do
    assert Dive.corrected_sum(input) == 900
  end

  test "2nd part. AoC challenge", %{challenge: input} do
    assert Dive.corrected_sum(input) == 1620141160
  end
end
