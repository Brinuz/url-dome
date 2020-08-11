import Config

config :urldome, Urldome.ExternalInterfaces.Repository.Postgres,
  database: "urldome",
  username: "postgres",
  hostname: "localhost"

config :urldome, ecto_repos: [Urldome.ExternalInterfaces.Repository.Postgres]
