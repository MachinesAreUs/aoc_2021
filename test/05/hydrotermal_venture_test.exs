defmodule HydrotermalVentureTest do
  use ExUnit.Case

  setup do
    sample = [
      [{0,9}, {5,9}],
      [{8,0}, {0,8}],
      [{9,4}, {3,4}],
      [{2,2}, {2,1}],
      [{7,0}, {7,4}],
      [{6,4}, {2,0}],
      [{0,9}, {2,9}],
      [{3,4}, {1,4}],
      [{0,0}, {8,8}],
      [{5,5}, {8,2}]
    ]

    {challenge, _} =
      "resources/05_lines.txt"
      |> File.read!()
      |> Code.eval_string()

    {:ok, sample: sample, challenge: challenge}
  end

  test "1st part. Sample input", %{sample: input} do
    assert HydrotermalVenture.line_overlaps(input) == 5
  end

  test "1st part. AoC challenge", %{challenge: input} do
    assert HydrotermalVenture.line_overlaps(input) == 6_283
  end

  test "2nd part. Sample input", %{sample: input} do
    assert HydrotermalVenture.line_overlaps2(input) == 12
  end

  test "2nd part. AoC challenge", %{challenge: input} do
    assert HydrotermalVenture.line_overlaps2(input) == 18_864
  end
end
