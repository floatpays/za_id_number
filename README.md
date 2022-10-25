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
ZaIdNumber.validate("12345")
```

## Development

To run the tests, ensure to update the csv file ./test/id_numbers.csv with your test cases.
