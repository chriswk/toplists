defmodule Toplists.DatabaseSeeder do
  alias Toplists.Repo
  alias Toplists.Info.Country

  @doc "Imports countries from the given CSV to the database"
  def insert_countries(country_path) do
    File.stream!(Path.expand(country_path))
    |> CSV.decode!(headers: true)
    |> Stream.map(fn row ->
      %Country{
        iso2: row["iso2"],
        iso3: row["iso3"],
        name: row["name"]
      }
    end)
    |> Stream.each(fn changeset ->
      Repo.insert!(changeset)
    end)
    |> Stream.run
  end

  def clear do
    Repo.delete_all
  end

end

Toplists.DatabaseSeeder.insert_countries("./priv/repo/countries.csv")
