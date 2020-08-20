defmodule Urldome.UseCases.RedirectBehaviour do
  @callback run(String.t()) :: {:ok, String.t()} | {:error, :not_found}
end
