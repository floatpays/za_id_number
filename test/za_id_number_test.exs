defmodule ZaIdNumberTest do
  use ExUnit.Case
  doctest ZaIdNumber

  test "greets the world" do
    assert ZaIdNumber.validate("1234") == {:error, "Invalid ID Number format"}
  end
end
