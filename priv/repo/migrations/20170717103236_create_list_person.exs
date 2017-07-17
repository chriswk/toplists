defmodule Toplists.Repo.Migrations.CreateToplists.List.Person do
  use Ecto.Migration

  def change do
    create table(:list_people) do
      add :name, :string
      add :born, :date
      add :tmdb_id, :integer
      add :imdb_id, :string

      timestamps()
    end

    create unique_index(:list_people, [:tmdb_id])
    create unique_index(:list_people, [:imdb_id])
  end
end
