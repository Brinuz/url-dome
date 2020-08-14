defmodule Urldome.ExternalInterfaces.Repository.RepoTest do
  use ExUnit.Case
  alias Urldome.ExternalInterfaces.Repository.{Postgres, Repo}
  alias Urldome.Entities.Url

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Postgres)
  end

  test "inserts and gets url" do
    with {:ok, %{hash: hash}} <- Repo.insert_url("ABCD1234", "http://www.google.com"),
         {:ok, url} <- Repo.get_url(hash) do
      assert url == %Url{hash: "ABCD1234", url: "http://www.google.com"}
    end
  end

  test "inserts and returns error on duplicated hash" do
    with {:ok, %{hash: hash}} <- Repo.insert_url("ABCD1234", "http://www.google.com"),
         {:error, err} <- Repo.insert_url(hash, "http://www.google.com") do
      assert err == :duplicated
    end
  end

  test "inserts and returns error on required" do
    {:error, err} = Repo.insert_url("", "http://www.google.com")
    assert err == :required
  end
end
