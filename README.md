# ZA Id Number 

Validates South African ID Numbers.

## Installation

```elixir
def deps do
  [
    {:za_id_number, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
iex> ZaIdNumber.validate("12345")
{:error, "Invalid ID Number format"}

iex> ZaIdNumber.validate("[valid id number]")
{:ok, %{
   gender: :male | :female,
   age: pos_integer(),
   date_of_birth: Date.t(),
   citizen_status: :born_citizen | :permanent_resident
  }
}

```

## Development

To run the tests, ensure to update the csv file ./test/id_numbers.csv with your test cases.
