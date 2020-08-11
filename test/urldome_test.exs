defmodule UrldomeTest do
  use ExUnit.Case
  doctest Urldome

  test "greets the world" do
    assert Urldome.hello() == :world
  end
end
