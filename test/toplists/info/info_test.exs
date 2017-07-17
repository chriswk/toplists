defmodule Toplists.InfoTest do
  use Toplists.DataCase

  alias Toplists.Info

  describe "countries" do
    alias Toplists.Info.Country

    @valid_attrs %{iso2: "some iso2", iso3: "some iso3", name: "some name"}
    @update_attrs %{iso2: "some updated iso2", iso3: "some updated iso3", name: "some updated name"}
    @invalid_attrs %{iso2: nil, iso3: nil, name: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Info.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Info.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Info.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Info.create_country(@valid_attrs)
      assert country.iso2 == "some iso2"
      assert country.iso3 == "some iso3"
      assert country.name == "some name"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Info.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, country} = Info.update_country(country, @update_attrs)
      assert %Country{} = country
      assert country.iso2 == "some updated iso2"
      assert country.iso3 == "some updated iso3"
      assert country.name == "some updated name"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Info.update_country(country, @invalid_attrs)
      assert country == Info.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Info.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Info.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Info.change_country(country)
    end
  end
end
