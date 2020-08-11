defmodule Urldome.ExternalInterfaces.Repository.Postgres.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add(:hash, :string, null: false, size: 10)
      add(:url, :string, null: false)
    end

    create(unique_index(:urls, [:hash]))
  end
end
