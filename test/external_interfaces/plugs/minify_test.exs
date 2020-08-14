defmodule Urldome.ExternalInterfaces.Plugs.MinifyTest do
  use ExUnit.Case
  use Plug.Test
  import Mox
  alias Urldome.ExternalInterfaces.Plugs.Router

  setup :verify_on_exit!

  test "minifies url" do
    Urldome.UseCases.MinifyMock
    |> expect(:run, fn "http://www.google.com", 3 ->
      {:ok, "ABCDE12345"}
    end)

    conn =
      :post
      |> conn("/minify", %{URL: "http://www.google.com"})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"hash\":\"ABCDE12345\",\"url\":\"http://www.google.com\"}"
  end

  test "minifies url and fails due to missing fields" do
    Urldome.UseCases.MinifyMock
    |> expect(:run, fn "", 3 -> {:error, :required} end)

    conn =
      :post
      |> conn("/minify", %{URL: ""})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 422
    assert conn.resp_body == "Missing required fields"
  end

  test "minifies url and fails due to unknown reasons" do
    Urldome.UseCases.MinifyMock
    |> expect(:run, fn "http://www.msn.com", 3 -> {:error, :unknown} end)

    conn =
      :post
      |> conn("/minify", %{URL: "http://www.msn.com"})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 422
    assert conn.resp_body == "Unknown error, try again"
  end

  test "minifies url and fails due to wrong body" do
    conn =
      :post
      |> conn("/minify", %{potato: ""})
      |> put_req_header("content-type", "application/json")
      |> Router.call(Router.init([]))

    assert conn.state == :sent
    assert conn.status == 400
    assert conn.resp_body == "Failed to parse body"
  end
end
