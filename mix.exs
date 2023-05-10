defmodule ZaIdNumber.MixProject do
  use Mix.Project

  def project do
    [
      app: :za_id_number,
      version: "0.1.4",
      elixir: "~> 1.14",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_parsec, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Wilhelm H Kirschbaum"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/floatpays/za_id_number"}
    ]
  end

  defp description do
    "Validates South African ID Numbers."
  end
end
