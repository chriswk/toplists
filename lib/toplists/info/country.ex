defmodule Toplists.Info.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias Toplists.Info.Country


  schema "info_countries" do
    field :iso2, :string
    field :iso3, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Country{} = country, attrs) do
    country
    |> cast(attrs, [:iso2, :iso3, :name])
    |> validate_required([:iso2, :iso3, :name])
    |> unique_constraint(:iso2)
    |> unique_constraint(:iso3)
  end
end
