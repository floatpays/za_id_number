defmodule ZaIdNumber do
  @moduledoc """
  Documentation for `ZaIdNumber`.
  """

  @spec validate(binary, keyword) ::
          {:ok, ZaIdNumber.Validator.result()} | {:error, binary()}
  @doc """
  ZaIdNumber validates and retrieves South African ID Number data

  ## Examples

      iex> ZaIdNumber.validate("12345")
      {:error, "Invalid ID Number format"}

  """
  defdelegate validate(id_number, opts \\ []), to: ZaIdNumber.Validator
end
