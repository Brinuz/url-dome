defmodule Urldome.ExternalInterfaces.Randomizer.HashTest do
  use ExUnit.Case
  alias Urldome.ExternalInterfaces.Randomizer.Hash

  test "hashes a string" do
    :rand.seed(:exsplus, {1, 2, 3})
    assert Hash.hash_string(10) == "bX9ZdtIy0D"
  end
end
