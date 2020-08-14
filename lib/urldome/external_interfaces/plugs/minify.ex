defmodule Urldome.ExternalInterfaces.Plugs.Minify do
  import Plug.Conn
  @minify Application.get_env(:urldome, :minify)

  @spec minify(Plug.Conn.t()) :: Plug.Conn.t()
  def minify(%Plug.Conn{params: params} = conn) do
    with %{"URL" => url} <- params,
         {:ok, hash} <- @minify.run(url, 3) do
      send_resp(conn, 200, Jason.encode!(%{url: url, hash: hash}))
    else
      {:error, :required} -> send_resp(conn, 422, "Missing required fields")
      {:error, :unknown} -> send_resp(conn, 422, "Unknown error, try again")
      _ -> send_resp(conn, 400, "Failed to parse body")
    end
  end
end
