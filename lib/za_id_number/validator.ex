defmodule ZaIdNumber.Validator do
  @moduledoc """
  SA ID Number format can be define as follow

  YYMMDDSSSSCAZ

  YY   - year of birth
  MM   - month of birth
  DD   - day of birth
  SSSS - gender classification
  C    - Citizen status
  A    - Unused
  Z    - Checksum
  """

  alias ZaIdNumber.Luhn

  import NimbleParsec

  defparsecp(
    :parse,
    integer(2)
    |> integer(2)
    |> integer(2)
    |> integer(4)
    |> integer(1)
    |> integer(1)
    |> integer(1)
  )

  @type result :: %{
          gender: :female | :male,
          age: number(),
          date_of_birth: Date.t(),
          citizen_status: :born_citizen | :permanent_resident
        }

  @doc """
  Validates and returns id number information.
  """
  @spec validate(id_number :: binary(), opts :: keyword()) ::
          {:ok, result()} | {:error, binary()}
  def validate(value, opts) do
    today = Keyword.get(opts, :today, Date.utc_today())

    case parse(value) do
      {:ok, [year, month, day, gender_code, c, _a, _z], _, _, _, _} ->
        with {:ok, date} <- calculate_date(today, year, month, day),
             age <- calculate_age(today, date),
             gender <- calculate_gender(gender_code),
             {:ok, citizen} <- calculate_citizen(c),
             :ok <- calculate_luhn(value) do
          {:ok,
           %{
             age: age,
             date_of_birth: date,
             gender: gender,
             citizen_status: citizen
           }}
        else
          {:error, error} -> {:error, error}
          _ -> {:error, "Invalid ID Number format"}
        end

      {:error, _, _, _, _, _} ->
        {:error, "Invalid ID Number format"}
    end
  end

  defp calculate_luhn(value) do
    if Luhn.valid?(value) do
      :ok
    else
      {:error, "Invalid ID Number checksum"}
    end
  end

  defp calculate_citizen(0), do: {:ok, :born_citizen}
  defp calculate_citizen(1), do: {:ok, :permanent_resident}
  defp calculate_citizen(_), do: {:error, "Invalid ID Number C code"}

  defp calculate_gender(code) when code > 4999, do: :male
  defp calculate_gender(_code), do: :female

  defp calculate_date(today, year, month, day) do
    year = if year + 2000 >= today.year, do: year + 1900, else: year + 2000

    case Date.new(year, month, day) do
      {:ok, date} -> {:ok, date}
      _ -> {:error, "Invalid ID Number date"}
    end
  end

  defp calculate_age(today, date) do
    diff = today.year - date.year

    if Date.compare(today, date) == :lt, do: diff - 1, else: diff
  end
end
