defmodule BinaryDiagnostic do

  @one "1"
  @zero "0"

  # 1st part

  def power_comsumption(report) do
    {gamma, epsilon} = calc_power_comsumption_params(report)
    gamma * epsilon
  end

  def calc_power_comsumption_params(report) do
    {gamma, epsilon} =
      report
      |> to_digits()
      |> calc_gamma_epsilon()

    {binary_to_decimal(gamma), binary_to_decimal(epsilon)}
  end

  def calc_gamma_epsilon(report_digits) do
    calculations = Enum.zip_with(report_digits, &calc_digits/1)

    Enum.reduce(calculations, {"", ""}, fn {d1, d2}, {gamma, epsilon} ->
       {gamma <> d1, epsilon <> d2}
    end)
  end

  def calc_digits(digits_column) do
    ones = Enum.count(digits_column, fn digit -> digit == @one end)
    zeroes = Enum.count(digits_column, fn digit -> digit == @zero end)
    {
      (if ones >= zeroes, do: @one, else: @zero), # beta
      (if ones <= zeroes, do: @one, else: @zero) # epsilon
    }
  end

  # 2nd part

  def life_support(report) do
    {o2_rating, co2_rating} = life_support_calc(report)
    o2_rating * co2_rating
  end

  def life_support_calc(report) do
    report_digits = to_digits(report)
    o2_rating = calc_o2_rating(0, report_digits)
    co2_rating = calc_co2_rating(0, report_digits)
    {o2_rating, co2_rating}
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

  defp digits_to_int(digits) do
    digits |> Enum.join |> binary_to_decimal()
  end

  defp to_digits(report) do
    Enum.map(report, fn str -> String.graphemes(str) end)
  end

  defp binary_to_decimal(bin) do
    {dec, _} = Integer.parse(bin, 2)
    dec
  end
end
