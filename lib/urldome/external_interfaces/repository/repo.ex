defmodule Urldome.ExternalInterfaces.Repository.Repo do
  @behaviour Urldome.ExternalInterfaces.Repository.RepoBehaviour

  alias Urldome.ExternalInterfaces.Repository.{Postgres, Schema}
  alias Urldome.Entities

  @spec insert_url(String.t(), String.t()) ::
          {:error, :duplicated | :required | :unknown} | {:ok, Entities.Url.t()}
  def insert_url(hash, url) do
    changeset = Schema.Url.changeset(%Schema.Url{}, %{hash: hash, url: url})

    case Postgres.insert(changeset) do
      {:ok, %{hash: hash, url: url}} -> {:ok, %Entities.Url{hash: hash, url: url}}
      {:error, cs} -> output_errors(cs)
    end
  end

  @spec get_url(String.t()) :: {:error, :not_found} | {:ok, Entities.Url.t()}
  def get_url(hash) do
    case Postgres.get_by(Schema.Url, hash: hash) do
      %{hash: hash, url: url} -> {:ok, %Entities.Url{hash: hash, url: url}}
      nil -> {:error, :not_found}
    end
  end

  defp output_errors(%{errors: errs}) do
    case errs do
      [{_, {_, [{:constraint, :unique} | _]}}] -> {:error, :duplicated}
      [{_, {_, [{:validation, :required} | _]}}] -> {:error, :required}
      _ -> {:error, :unknown}
    end
  end
end
