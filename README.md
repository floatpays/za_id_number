# ZA Id Number

Validates South African ID Numbers according to the official format and returns parsed information including date of birth, gender, age, and citizenship status.

## Installation

```elixir
def deps do
  [
    {:za_id_number, "~> 1.1"}
  ]
end
```

## South African ID Number Format

South African ID numbers are 13 digits long and follow the format: `YYMMDDSSSSCAZ`

- **YYMMDD** (positions 1-6): Date of birth (e.g., 920220 = 20 February 1992)
- **SSSS** (positions 7-10): Gender sequence number (0-4999 for females, 5000-9999 for males)
- **C** (position 11): Citizenship status (0 = born citizen, 1 = permanent resident)
- **A** (position 12): Historical field (unused, typically 8 or 9)
- **Z** (position 13): Checksum digit calculated using the Luhn algorithm

## Usage

```elixir
# Invalid ID number
iex> ZaIdNumber.validate("12345")
{:error, "Invalid ID Number format"}

# Valid ID number (example: 8001015009087)
iex> ZaIdNumber.validate("8001015009087")
{:ok, %{
   gender: :male,
   age: 45,
   date_of_birth: ~D[1980-01-01],
   citizen_status: :born_citizen
  }
}

# You can optionally pass a reference date for testing
iex> ZaIdNumber.validate("8001015009087", today: ~D[2024-06-15])
{:ok, %{
   gender: :male,
   age: 44,
   date_of_birth: ~D[1980-01-01],
   citizen_status: :born_citizen
  }
}
```

## Error Messages

The validator returns descriptive error messages:

- `"Invalid ID Number format"` - Not 13 digits or contains non-numeric characters
- `"Invalid ID Number date"` - Invalid date (e.g., month > 12, day > 31)
- `"Invalid ID Number checksum"` - Luhn checksum validation failed
- `"Invalid ID Number C code"` - Citizenship code is not 0 or 1

## Development

To run the tests:

```bash
mix test
```

For code quality checks:

```bash
mix credo --strict
mix dialyzer
```

To add more test cases, update the CSV file at `./test/za_id_number/id_numbers.csv`.
