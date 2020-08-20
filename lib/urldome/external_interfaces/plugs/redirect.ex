defmodule Urldome.ExternalInterfaces.Plugs.Redirect do
  import Plug.Conn
  @redirect Application.get_env(:urldome, :redirect)

  @spec redirect(Plug.Conn.t()) :: Plug.Conn.t()
  def redirect(%Plug.Conn{params: params} = conn) do
    with %{"hash" => hash} <- params,
         {:ok, url} <- @redirect.run(hash) do
      send_resp(conn, 200, Jason.encode!(%{url: url, hash: hash}))
    else
      {:error, :not_found} -> send_resp(conn, 404, "No matching url for that specified hash")
      _ -> send_resp(conn, 400, "Failed to parse body")
    end
  end
end
