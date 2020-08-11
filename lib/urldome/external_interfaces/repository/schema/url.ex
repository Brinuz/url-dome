defmodule Urldome.ExternalInterfaces.Repository.Schema.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field(:hash, :string)
    field(:url, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:hash, :url])
    |> validate_required([:hash, :url])
  end
end
