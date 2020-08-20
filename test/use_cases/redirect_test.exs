defmodule Urldome.UseCases.RedirectTest do
  use ExUnit.Case
  import Mox
  alias Urldome.Entities.Url

  setup :verify_on_exit!

  test "successfully obtains redirect URL" do
    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:get_url, fn "ABCDE12345" ->
      {:ok, %Url{hash: "ABCDE12345", url: "http://www.google.com"}}
    end)

    assert Urldome.UseCases.Redirect.run("ABCDE12345") == {:ok, "http://www.google.com"}
  end

  test "doesn't find redirect URL" do
    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:get_url, fn "ABCDE12345" -> {:error, :not_found} end)

    assert Urldome.UseCases.Redirect.run("ABCDE12345") == {:error, :not_found}
  end
end
