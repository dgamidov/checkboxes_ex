defmodule CheckboxesEx.ColorControllerTest do
  use CheckboxesEx.ConnCase

  alias CheckboxesEx.Color
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, color_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing colors"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, color_path(conn, :new)
    assert html_response(conn, 200) =~ "New color"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, color_path(conn, :create), color: @valid_attrs
    assert redirected_to(conn) == color_path(conn, :index)
    assert Repo.get_by(Color, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, color_path(conn, :create), color: @invalid_attrs
    assert html_response(conn, 200) =~ "New color"
  end

  test "shows chosen resource", %{conn: conn} do
    color = Repo.insert! %Color{}
    conn = get conn, color_path(conn, :show, color)
    assert html_response(conn, 200) =~ "Show color"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, color_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    color = Repo.insert! %Color{}
    conn = get conn, color_path(conn, :edit, color)
    assert html_response(conn, 200) =~ "Edit color"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    color = Repo.insert! %Color{}
    conn = put conn, color_path(conn, :update, color), color: @valid_attrs
    assert redirected_to(conn) == color_path(conn, :show, color)
    assert Repo.get_by(Color, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    color = Repo.insert! %Color{}
    conn = put conn, color_path(conn, :update, color), color: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit color"
  end

  test "deletes chosen resource", %{conn: conn} do
    color = Repo.insert! %Color{}
    conn = delete conn, color_path(conn, :delete, color)
    assert redirected_to(conn) == color_path(conn, :index)
    refute Repo.get(Color, color.id)
  end
end
