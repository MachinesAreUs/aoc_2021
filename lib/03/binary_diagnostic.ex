defmodule BinaryDiagnostic do

  def power_comsumption(report) do
    {gamma, epsilon} = power_comsumption_calc(report)
    gamma * epsilon
  end

  def power_comsumption_calc(report) do
    bits = Enum.map(report, fn str -> String.graphemes(str) end)

    calculations = Enum.zip_with(bits, fn digits ->
      ones = Enum.count(digits, fn digit -> digit == "1" end)
      zeroes = Enum.count(digits, fn digit -> digit == "0" end)
      {
        (if ones >= zeroes, do: "1", else: "0"),
        (if ones <= zeroes, do: "1", else: "0")
      }
    end)

    {gamma, epsilon} = Enum.reduce(calculations, {"", ""}, fn {d1, d2}, {gamma, epsilon} ->
      {gamma <> d1, epsilon <> d2}
    end)

    {gamma_dec, _} = Integer.parse(gamma, 2)
    {epsilon_dec, _} = Integer.parse(epsilon, 2)
    {gamma_dec, epsilon_dec}
  end

  def life_support(report) do
    {o2_rating, co2_rating} = life_support_calc(report)
    o2_rating * co2_rating
  end

  def life_support_calc(report) do
    bits = Enum.map(report, fn str -> String.graphemes(str) end)
    o2_rating = calc_o2_rating(0, bits)
    co2_rating = calc_co2_rating(0, bits)
    {o2_rating, co2_rating}
  end

  defp digits_to_int(digits) do
    {val, _} = digits |> Enum.join |> Integer.parse(2)
    val
  end

  def calc_o2_rating(_, [h | []]) do
    digits_to_int(h)
  end

  def calc_o2_rating(idx, report) do
    column = Enum.map(report, fn digits -> Enum.at(digits, idx) end)

    ones = Enum.count(column, fn digit -> digit == "1" end)
    zeroes = Enum.count(column, fn digit -> digit == "0" end)

    candidates =
      if ones >= zeroes do
        Enum.filter(report, fn digits -> Enum.at(digits, idx) == "1" end)
      else
        Enum.filter(report, fn digits -> Enum.at(digits, idx) == "0" end)
      end
    #IO.inspect candidates
    calc_o2_rating(idx + 1, candidates)
  end

  def calc_co2_rating(_, [h | []]) do
    digits_to_int(h)
  end

  def calc_co2_rating(idx, report) do
    column = Enum.map(report, fn digits -> Enum.at(digits, idx) end)

    ones = Enum.count(column, fn digit -> digit == "1" end)
    zeroes = Enum.count(column, fn digit -> digit == "0" end)

    candidates =
      if ones < zeroes do
        Enum.filter(report, fn digits -> Enum.at(digits, idx) == "1" end)
      else
        Enum.filter(report, fn digits -> Enum.at(digits, idx) == "0" end)
      end
    #IO.inspect candidates
    calc_co2_rating(idx + 1, candidates)
  end
end
