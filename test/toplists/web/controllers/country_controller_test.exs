defmodule Toplists.Web.CountryControllerTest do
  use Toplists.Web.ConnCase

  alias Toplists.Info

  @create_attrs %{iso2: "some iso2", iso3: "some iso3", name: "some name"}
  @update_attrs %{iso2: "some updated iso2", iso3: "some updated iso3", name: "some updated name"}
  @invalid_attrs %{iso2: nil, iso3: nil, name: nil}

  def fixture(:country) do
    {:ok, country} = Info.create_country(@create_attrs)
    country
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, country_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Countries"
  end

  test "renders form for new countries", %{conn: conn} do
    conn = get conn, country_path(conn, :new)
    assert html_response(conn, 200) =~ "New Country"
  end

  test "creates country and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, country_path(conn, :create), country: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == country_path(conn, :show, id)

    conn = get conn, country_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Country"
  end

  test "does not create country and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, country_path(conn, :create), country: @invalid_attrs
    assert html_response(conn, 200) =~ "New Country"
  end

  test "renders form for editing chosen country", %{conn: conn} do
    country = fixture(:country)
    conn = get conn, country_path(conn, :edit, country)
    assert html_response(conn, 200) =~ "Edit Country"
  end

  test "updates chosen country and redirects when data is valid", %{conn: conn} do
    country = fixture(:country)
    conn = put conn, country_path(conn, :update, country), country: @update_attrs
    assert redirected_to(conn) == country_path(conn, :show, country)

    conn = get conn, country_path(conn, :show, country)
    assert html_response(conn, 200) =~ "some updated iso2"
  end

  test "does not update chosen country and renders errors when data is invalid", %{conn: conn} do
    country = fixture(:country)
    conn = put conn, country_path(conn, :update, country), country: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Country"
  end

  test "deletes chosen country", %{conn: conn} do
    country = fixture(:country)
    conn = delete conn, country_path(conn, :delete, country)
    assert redirected_to(conn) == country_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, country_path(conn, :show, country)
    end
  end
end
