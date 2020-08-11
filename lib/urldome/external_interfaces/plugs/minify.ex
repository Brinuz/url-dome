defmodule Urldome.ExternalInterfaces.Plugs.Minify do
  import Plug.Conn
  alias Urldome.UseCases

  defmodule BadRequestError do
    @moduledoc """
    Error raised when a required field is in the body is missing.
    """

    defexception message: ""
  end

  def minify(%Plug.Conn{params: params} = conn) do
    case params do
      %{"URL" => url} -> UseCases.Minify.run(url, 1)
      _ -> raise(BadRequestError)
    end

    send_resp(conn, 204, "")
  end
end
