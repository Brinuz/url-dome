defmodule Urldome.UseCases.MinifyTest do
  use ExUnit.Case
  import Mox
  alias Urldome.Entities.Url

  setup :verify_on_exit!

  test "successfully Minifies URL" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, fn _ -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, fn hash, url -> {:ok, %Url{hash: hash, url: url}} end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:ok, "ABCDE12345"}
  end

  test "unuccessfully Minifies URL" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, fn _ -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, fn _, _ -> {:error, :required} end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:error, :required}
  end

  test "successfully Minifies URL with duplications" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, 3, fn _ -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, 2, fn _, _ -> {:error, :duplicated} end)
    |> expect(:insert_url, 1, fn hash, url -> {:ok, %Url{hash: hash, url: url}} end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:ok, "ABCDE12345"}
  end

  test "unuccessfully Minifies URL with duplications" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, 3, fn _ -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, 3, fn _, _ -> {:error, :duplicated} end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:error, :unknown}
  end
end
