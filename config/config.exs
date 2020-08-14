import Config

config :urldome, Urldome.ExternalInterfaces.Repository.Postgres,
  database: "urldome",
  username: "postgres",
  hostname: "localhost"

config :urldome, ecto_repos: [Urldome.ExternalInterfaces.Repository.Postgres]
config :urldome, repo: Urldome.ExternalInterfaces.Repository.Repo
config :urldome, randomizer: Urldome.ExternalInterfaces.Randomizer.Hash
config :urldome, minify: Urldome.UseCases.Minify

import_config "#{Mix.env()}.exs"
