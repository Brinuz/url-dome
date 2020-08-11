defmodule Urldome.UseCases.Minify do
  alias Urldome.ExternalInterfaces.Repository.Repo

  def run(url, _tries, repository \\ Repo) do
    repository.insert_url(url, "dummy_hash")
  end
end
