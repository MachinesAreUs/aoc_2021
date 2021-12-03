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
    {ones, zeroes} = count_digits(digits_column)
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

  def calc_o2_rating(idx, candidates) do
    column = nth_column(idx, candidates)

    {ones, zeroes} = count_digits(column)

    new_candidates =
      if ones >= zeroes do
        filter_candidates(candidates, idx, @one)
      else
        filter_candidates(candidates, idx, @zero)
      end

    calc_o2_rating(idx + 1, new_candidates)
  end

  def calc_co2_rating(_, [h | []]) do
    digits_to_int(h)
  end

  def calc_co2_rating(idx, candidates) do
    column = nth_column(idx, candidates)

    {ones, zeroes} = count_digits(column)

    new_candidates =
      if ones < zeroes do
        filter_candidates(candidates, idx, @one)
      else
        filter_candidates(candidates, idx, @zero)
      end

    calc_co2_rating(idx + 1, new_candidates)
  end

  defp filter_candidates(candidates, idx, val) do
    Enum.filter(candidates, fn digits -> Enum.at(digits, idx) == val end)
  end

  # Util functions

  defp nth_column(idx, matrix) do
    Enum.map(matrix, fn digits -> Enum.at(digits, idx) end)
  end

  defp count_digits(digits) do
    ones = Enum.count(digits, fn digit -> digit == @one end)
    zeroes = Enum.count(digits, fn digit -> digit == @zero end)
    {ones, zeroes}
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
