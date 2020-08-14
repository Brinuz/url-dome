defmodule Urldome.ExternalInterfaces.Randomizer.Hash do
  @behaviour Urldome.ExternalInterfaces.Randomizer.HashBehaviour
  @char_list "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789"

  @spec hash_string(integer) :: String.t()
  def hash_string(length) do
    graphemes = String.graphemes(@char_list)

    1..length
    |> Enum.reduce([], fn _, acc -> [Enum.random(graphemes) | acc] end)
    |> Enum.reverse()
    |> Enum.join()
  end
end
