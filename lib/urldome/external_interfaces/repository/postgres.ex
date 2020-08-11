defmodule Urldome.ExternalInterfaces.Repository.Postgres do
  use Ecto.Repo,
    otp_app: :urldome,
    adapter: Ecto.Adapters.Postgres
end
