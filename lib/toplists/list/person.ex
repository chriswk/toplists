defmodule Toplists.List.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Toplists.List.Person


  schema "list_people" do
    field :born, :date
    field :imdb_id, :string
    field :name, :string
    field :tmdb_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:name, :born, :tmdb_id, :imdb_id])
    |> validate_required([:name, :born, :tmdb_id, :imdb_id])
    |> unique_constraint(:tmdb_id)
    |> unique_constraint(:imdb_id)
  end
end
