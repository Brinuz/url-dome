defmodule Urldome.MixProject do
  use Mix.Project

  def project do
    [
      app: :urldome,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Urldome.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.3.0"},
      {:jason, "~> 1.2.1"},
      {:ecto_sql, "~> 3.4.5"},
      {:postgrex, "~> 0.15.5"}
    ]
  end
end
