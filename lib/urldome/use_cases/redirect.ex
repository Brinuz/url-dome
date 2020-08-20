defmodule Urldome.UseCases.Redirect do
  @behaviour Urldome.UseCases.RedirectBehaviour

  @repo Application.get_env(:urldome, :repo)

  alias Urldome.Entities

  @spec run(String.t()) :: {:ok, String.t()} | {:error, :not_found}
  def run(hash) do
    case @repo.get_url(hash) do
      {:ok, %Entities.Url{hash: _, url: url}} -> {:ok, url}
      {:error, :not_found} -> {:error, :not_found}
    end
  end
end
