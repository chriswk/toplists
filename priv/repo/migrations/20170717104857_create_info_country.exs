defmodule Toplists.Repo.Migrations.CreateToplists.Info.Country do
  use Ecto.Migration

  def change do
    create table(:info_countries) do
      add :iso2, :string
      add :iso3, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:info_countries, [:iso2])
    create unique_index(:info_countries, [:iso3])
  end
end
