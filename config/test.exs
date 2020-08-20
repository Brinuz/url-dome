use Mix.Config

config :urldome, Urldome.ExternalInterfaces.Repository.Postgres,
  username: "postgres",
  hostname: "localhost",
  database: "urldome_test",
  pool: Ecto.Adapters.SQL.Sandbox

config :urldome, repo: Urldome.ExternalInterfaces.Repository.RepoMock
config :urldome, randomizer: Urldome.ExternalInterfaces.Randomizer.HashMock
config :urldome, minify: Urldome.UseCases.MinifyMock
config :urldome, redirect: Urldome.UseCases.RedirectMock
