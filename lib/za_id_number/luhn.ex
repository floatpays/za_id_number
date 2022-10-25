defmodule ZaIdNumber.Luhn do
  @moduledoc """
  Luhn algorith for validation.

  Reference: https://en.wikipedia.org/wiki/Luhn_algorithm
  """

  def generate(prefix, length) do
    prefix_nums = reverse_digits(prefix)

    digits = random_digits(length - 1 - Enum.count(prefix_nums)) ++ prefix_nums

    # 0 the last digit as a placeholder for the calculation
    checksum =
      [0 | digits]
      |> double_even()
      |> sum_digits()

    [rem(checksum * 9, 10) | digits]
    |> Enum.reverse()
    |> Enum.join()
  end

  defp random_digits(length) when length > 0 do
    for _ <- 1..length, do: :rand.uniform(9)
  end

  defp random_digits(_), do: []

  def valid?(number) when is_binary(number) do
    checksum =
      number
      |> reverse_digits()
      |> double_even()
      |> sum_digits()
      |> rem(10)

    checksum == 0
  end

  defp reverse_digits(number) when is_binary(number) do
    number
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()
  end

  defp double_even([]), do: []
  defp double_even([x]), do: [x]
  defp double_even([x, y | xs]), do: [x, y * 2 | double_even(xs)]

  defp sum_digits([]), do: 0
  defp sum_digits([x | xs]) when x > 9, do: sum_digits([x - 9 | xs])
  defp sum_digits([x | xs]), do: x + sum_digits(xs)
end
