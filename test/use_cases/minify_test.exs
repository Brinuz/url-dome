defmodule Urldome.UseCases.MinifyTest do
  use ExUnit.Case
  import Mox
  alias Urldome.Entities.Url

  setup :verify_on_exit!

  test "successfully Minifies URL" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, fn 10 -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, fn hash, "http://www.google.com" -> {:ok, %Url{hash: hash}} end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:ok, "ABCDE12345"}
  end

  test "unuccessfully Minifies URL" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, fn 10 -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, fn "ABCDE12345", "http://www.google.com" -> {:error, :required} end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:error, :required}
  end

  test "successfully Minifies URL with duplications" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, 3, fn 10 -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, 2, fn "ABCDE12345", "http://www.google.com" ->
      {:error, :duplicated}
    end)
    |> expect(:insert_url, 1, fn "ABCDE12345", "http://www.google.com" ->
      {:ok, %Url{hash: "ABCDE12345"}}
    end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:ok, "ABCDE12345"}
  end

  test "unuccessfully Minifies URL with duplications" do
    Urldome.ExternalInterfaces.Randomizer.HashMock
    |> expect(:hash_string, 3, fn 10 -> "ABCDE12345" end)

    Urldome.ExternalInterfaces.Repository.RepoMock
    |> expect(:insert_url, 3, fn "ABCDE12345", "http://www.google.com" ->
      {:error, :duplicated}
    end)

    assert Urldome.UseCases.Minify.run("http://www.google.com", 3) == {:error, :unknown}
  end
end
