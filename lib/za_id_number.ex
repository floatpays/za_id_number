defmodule ZaIdNumber do
  @moduledoc """
  Documentation for `ZaIdNumber`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ZaIdNumber.validate("12345")
      {:error, "Invalid ID Number format"}

  """
  defdelegate validate(id_number, opts \\ []), to: ZaIdNumber.Validator
end
