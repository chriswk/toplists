defmodule Toplists.Web.PersonControllerTest do
  use Toplists.Web.ConnCase

  alias Toplists.List

  @create_attrs %{born: ~D[2010-04-17], imdb_id: "some imdb_id", name: "some name", tmdb_id: 42}
  @update_attrs %{born: ~D[2011-05-18], imdb_id: "some updated imdb_id", name: "some updated name", tmdb_id: 43}
  @invalid_attrs %{born: nil, imdb_id: nil, name: nil, tmdb_id: nil}

  def fixture(:person) do
    {:ok, person} = List.create_person(@create_attrs)
    person
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, person_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing People"
  end

  test "renders form for new people", %{conn: conn} do
    conn = get conn, person_path(conn, :new)
    assert html_response(conn, 200) =~ "New Person"
  end

  test "creates person and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, person_path(conn, :create), person: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == person_path(conn, :show, id)

    conn = get conn, person_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Person"
  end

  test "does not create person and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, person_path(conn, :create), person: @invalid_attrs
    assert html_response(conn, 200) =~ "New Person"
  end

  test "renders form for editing chosen person", %{conn: conn} do
    person = fixture(:person)
    conn = get conn, person_path(conn, :edit, person)
    assert html_response(conn, 200) =~ "Edit Person"
  end

  test "updates chosen person and redirects when data is valid", %{conn: conn} do
    person = fixture(:person)
    conn = put conn, person_path(conn, :update, person), person: @update_attrs
    assert redirected_to(conn) == person_path(conn, :show, person)

    conn = get conn, person_path(conn, :show, person)
    assert html_response(conn, 200) =~ "some updated imdb_id"
  end

  test "does not update chosen person and renders errors when data is invalid", %{conn: conn} do
    person = fixture(:person)
    conn = put conn, person_path(conn, :update, person), person: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Person"
  end

  test "deletes chosen person", %{conn: conn} do
    person = fixture(:person)
    conn = delete conn, person_path(conn, :delete, person)
    assert redirected_to(conn) == person_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, person_path(conn, :show, person)
    end
  end
end
