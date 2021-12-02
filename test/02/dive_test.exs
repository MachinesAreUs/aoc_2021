defmodule DiveTest do
  use ExUnit.Case

  test "1st part. Sample input" do
    course =
      [
        {"forward", 5},
        {"down", 5},
        {"forward", 8},
        {"up", 3},
        {"down", 8},
        {"forward", 2}
      ]

    assert Dive.sum(course) == 150
  end

  test "1st part. AoC challenge" do
    course =
      "./resources/02_course.txt"
      |> File.stream!()
      |> Stream.map(fn str ->
        [type, val_str] = String.split(str)
        {val, _} = Integer.parse(val_str)
        {type, val}
      end)

    assert Dive.sum(course) == 1451208
  end
end
