defmodule CheckboxesEx.SizeControllerTest do
  use CheckboxesEx.ConnCase

  alias CheckboxesEx.Size
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, size_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sizes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, size_path(conn, :new)
    assert html_response(conn, 200) =~ "New size"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, size_path(conn, :create), size: @valid_attrs
    assert redirected_to(conn) == size_path(conn, :index)
    assert Repo.get_by(Size, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, size_path(conn, :create), size: @invalid_attrs
    assert html_response(conn, 200) =~ "New size"
  end

  test "shows chosen resource", %{conn: conn} do
    size = Repo.insert! %Size{}
    conn = get conn, size_path(conn, :show, size)
    assert html_response(conn, 200) =~ "Show size"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, size_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    size = Repo.insert! %Size{}
    conn = get conn, size_path(conn, :edit, size)
    assert html_response(conn, 200) =~ "Edit size"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    size = Repo.insert! %Size{}
    conn = put conn, size_path(conn, :update, size), size: @valid_attrs
    assert redirected_to(conn) == size_path(conn, :show, size)
    assert Repo.get_by(Size, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    size = Repo.insert! %Size{}
    conn = put conn, size_path(conn, :update, size), size: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit size"
  end

  test "deletes chosen resource", %{conn: conn} do
    size = Repo.insert! %Size{}
    conn = delete conn, size_path(conn, :delete, size)
    assert redirected_to(conn) == size_path(conn, :index)
    refute Repo.get(Size, size.id)
  end
end
