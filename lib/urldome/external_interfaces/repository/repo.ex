defmodule Urldome.ExternalInterfaces.Repository.Repo do
  alias Urldome.ExternalInterfaces.Repository.{Postgres, Schema.Url}

  defmodule EmptyFieldError do
    @moduledoc """
    Error raised when a required field is empty
    """

    defexception message: ""
  end

  def insert_url(url, hash) do
    changeset = Url.changeset(%Url{}, %{url: url, hash: hash})

    case Postgres.insert(changeset) do
      {:ok, %{id: id}} -> id
      {:error, _} -> raise(EmptyFieldError)
    end
  end
end
