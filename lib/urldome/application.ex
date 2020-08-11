defmodule Urldome.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy,
       scheme: :http, plug: Urldome.ExternalInterfaces.Plugs.Router, options: [port: 8080]},
      Urldome.ExternalInterfaces.Repository.Postgres
    ]

    IO.puts("Starting app...")

    opts = [strategy: :one_for_one, name: Urldome.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
