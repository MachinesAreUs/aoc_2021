defmodule BinaryDiagnosticTest do
  use ExUnit.Case

  test "1st part. Sampel input" do
    input =
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
    assert BinaryDiagnostic.power_comsumption(input) == 198
  end

  test "2nd part. AoC input" do
    input =
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
    assert BinaryDiagnostic.life_support(input) == 230
  end

  test "1st part. AoC challenge" do
    input =
      "resources/03_report.txt"
      |> File.stream!()

    assert BinaryDiagnostic.power_comsumption(input) == 3633500
  end

  test "2nd part. AoC challenge" do
    input =
      "resources/03_report.txt"
      |> File.stream!()

    assert BinaryDiagnostic.life_support(input) == 4550283
  end
end
