defmodule Urldome.UseCases.MinifyBehaviour do
  @callback run(String.t(), integer) ::
              {:ok, String.t()} | {:error, :required | :duplicated | :unknown}
end
