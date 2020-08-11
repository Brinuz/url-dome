defmodule Urldome.ExternalInterfaces.Plugs.Router do
  import Urldome.ExternalInterfaces.Plugs.Minify
  use Plug.Router

  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  post "/minify" do
    minify(conn)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
