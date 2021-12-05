defmodule GiantSquidTest do
  use ExUnit.Case

  setup do
    nums =
      [
        7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16,
        13, 6, 15, 25, 12, 22, 18, 20, 8, 19, 3, 26, 1
      ]

    boards =
      [
        [
          [22, 13, 17, 11,  0],
          [8,   2, 23,  4, 24],
          [21,  9, 14, 16,  7],
          [6,  10,  3, 18,  5],
          [1,  12, 20, 15, 19]
        ],
        [
          [3,  15,  0,  2, 22],
          [9,  18, 13, 17,  5],
          [19,  8,  7, 25, 23],
          [20, 11, 10, 24,  4],
          [14, 21, 16, 12,  6]
        ],
        [
          [14, 21, 17, 24,  4],
          [10, 16, 15,  9, 19],
          [18,  8, 23, 26, 20],
          [22, 11, 13,  6,  5],
          [2,   0, 12,  3,  7]
        ]
      ]

    challenge = [nums: _, boards: _] =
      "resources/04_bingo.txt"
      |> File.stream!()
      |> BingoParser.parse()

    {:ok, sample: [nums: nums, boards: boards], challenge: challenge}
  end

  test "1st part. Sample input", %{sample: [nums: nums, boards: boards]} do
    assert GiantSquid.bingo_winner(nums, boards) == 4_512
  end

  test "1st part. AoC challeng", %{challenge: [nums: nums, boards: boards]} do
    assert GiantSquid.bingo_winner(nums, boards) == 54_275
  end

  test "2nd part. Sample input", %{sample: [nums: nums, boards: boards]} do
    assert GiantSquid.last_winner(nums, boards) == 1_924
  end

  test "2nd part. AoC challeng", %{challenge: [nums: nums, boards: boards]} do
    IO.puts GiantSquid.last_winner(nums, boards)
    #assert GiantSquid.last_winner(nums, boards) == 54_275
  end
end
