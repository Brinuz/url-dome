defmodule Urldome.UseCases.Minify do
  @behaviour Urldome.UseCases.MinifyBehaviour

  @repo Application.get_env(:urldome, :repo)
  @randomizer Application.get_env(:urldome, :randomizer)

  @spec run(String.t(), integer) ::
          {:ok, String.t()} | {:error, :required | :duplicated | :unknown}
  def run(url, tries \\ 3)

  def run(url, tries) when tries >= 1 do
    hash = @randomizer.hash_string(10)

    case @repo.insert_url(hash, url) do
      {:ok, %{hash: hash}} -> {:ok, hash}
      {:error, :required} -> {:error, :required}
      {:error, :duplicated} -> run(url, tries - 1)
    end
  end

  def run(_, tries) when tries < 1, do: {:error, :unknown}
end
