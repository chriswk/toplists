defmodule Toplists.ListTest do
  use Toplists.DataCase

  alias Toplists.List

  describe "people" do
    alias Toplists.List.Person

    @valid_attrs %{born: ~D[2010-04-17], imdb_id: "some imdb_id", name: "some name", tmdb_id: 42}
    @update_attrs %{born: ~D[2011-05-18], imdb_id: "some updated imdb_id", name: "some updated name", tmdb_id: 43}
    @invalid_attrs %{born: nil, imdb_id: nil, name: nil, tmdb_id: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> List.create_person()

      person
    end

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert List.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert List.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = List.create_person(@valid_attrs)
      assert person.born == ~D[2010-04-17]
      assert person.imdb_id == "some imdb_id"
      assert person.name == "some name"
      assert person.tmdb_id == 42
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = List.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, person} = List.update_person(person, @update_attrs)
      assert %Person{} = person
      assert person.born == ~D[2011-05-18]
      assert person.imdb_id == "some updated imdb_id"
      assert person.name == "some updated name"
      assert person.tmdb_id == 43
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = List.update_person(person, @invalid_attrs)
      assert person == List.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = List.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> List.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = List.change_person(person)
    end
  end
end
