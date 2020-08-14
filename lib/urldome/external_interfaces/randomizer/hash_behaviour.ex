defmodule Urldome.ExternalInterfaces.Randomizer.HashBehaviour do
  @callback hash_string(integer) :: String.t()
end
