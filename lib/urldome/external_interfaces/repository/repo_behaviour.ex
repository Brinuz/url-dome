defmodule Urldome.ExternalInterfaces.Repository.RepoBehaviour do
  alias Urldome.Entities.Url

  @callback insert_url(String.t(), String.t()) ::
              {:error, :duplicated | :required | :unknown} | {:ok, Url.t()}
  @callback get_url(String.t()) :: {:error, :not_found} | {:ok, Url.t()}
end
