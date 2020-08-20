defmodule Urldome.ExternalInterfaces.Plugs.RedirectTest do
  use ExUnit.Case
  use Plug.Test
  import Mox
  alias Urldome.ExternalInterfaces.Plugs.Router

  setup :verify_on_exit!

  test "redirects from hash" do
    Urldome.UseCases.RedirectMock
    |> expect(:run, fn "ABCDE12345" -> {:ok, "http://www.google.com"} end)

    conn =
      :get
      |> conn("/redirect", %{hash: "ABCDE12345"})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"hash\":\"ABCDE12345\",\"url\":\"http://www.google.com\"}"
  end

  test "minifies url and fails due to unexisting hash" do
    Urldome.UseCases.RedirectMock
    |> expect(:run, fn "" -> {:error, :not_found} end)

    conn =
      :get
      |> conn("/redirect", %{hash: ""})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "No matching url for that specified hash"
  end

  test "minifies url and fails due to wrong body" do
    conn =
      :get
      |> conn("/redirect", %{potato: ""})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 400
    assert conn.resp_body == "Failed to parse body"
  end
end
