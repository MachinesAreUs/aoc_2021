defmodule BinaryDiagnosticTest do
  use ExUnit.Case

  setup do
    sample =
      [
        "00100",
        "11110",
        "10110",
        "10111",
        "10101",
        "01111",
        "00111",
        "11100",
        "10000",
        "11001",
        "00010",
        "01010"
      ]

    challenge = File.stream!("resources/03_report.txt")

    {:ok, sample: sample, challenge: challenge}
  end

  test "1st part. Sampel input", %{sample: input} do
    assert BinaryDiagnostic.power_comsumption(input) == 198
  end

  test "1st part. AoC challenge", %{challenge: input} do
    assert BinaryDiagnostic.power_comsumption(input) == 3_633_500
  end

  test "2nd part. Sample input", %{sample: input} do
    assert BinaryDiagnostic.life_support(input) == 230
  end

  test "2nd part. AoC challenge", %{challenge: input} do
    assert BinaryDiagnostic.life_support(input) == 4_550_283
  end
end
