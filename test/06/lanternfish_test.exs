defmodule LanterfishTest do
  use ExUnit.Case

  setup do
    sample = [3, 4, 3, 1, 2]

    {challenge, _} =
      "resources/06_lanternfish.txt"
      |> File.read!()
      |> Code.eval_string()

    {:ok, sample: sample, challenge: challenge}
  end

  test "1st part. Sample input", %{sample: input} do
    assert Lanternfish.calculate_fish(input, 18) == 26
    assert Lanternfish.calculate_fish(input, 80) == 5_934
  end

  test "1st part. AoC challenge", %{challenge: input} do
    assert Lanternfish.calculate_fish(input, 80) == 351_188
  end
end
