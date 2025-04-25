defmodule ZaIdNumber.ValidatorTest do
  use ExUnit.Case, async: true

  alias ZaIdNumber.Validator

  @external_resource ids_path = Path.join([__DIR__, "id_numbers.csv"])

  test "handle nil" do
    assert Validator.validate(nil) == {:error, "Invalid ID Number format"}
  end

  test "handle integer" do
    assert Validator.validate(123.12) == {:error, "Invalid ID Number format"}
  end

  test "handle non textual integers" do
    assert Validator.validate("8401111111111.00") ==
             {:error, "Invalid ID Number format"}
  end

  test "default options" do
    assert Validator.validate("8401") == {:error, "Invalid ID Number format"}
  end

  for line <- File.stream!(ids_path, [], :line) do
    [today, id_number, gender, age, date_of_birth, citizen_status, error] =
      String.split(line, ",") |> Enum.map(&String.trim/1)

    unless id_number == "id_number" do
      test "test id number #{id_number}" do
        date = Date.from_iso8601!(unquote(today))
        result = Validator.validate(unquote(id_number), today: date)

        case result do
          {:error, msg} ->
            assert msg == unquote(error)

          {
            :ok,
            %{
              gender: gender,
              age: age,
              date_of_birth: dob,
              citizen_status: status
            }
          } ->
            assert to_string(gender) == unquote(gender)
            assert to_string(age) == unquote(age)
            assert to_string(dob) == unquote(date_of_birth)
            assert to_string(status) == unquote(citizen_status)
        end
      end
    end
  end
end
