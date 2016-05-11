defmodule CheckboxesEx.ColorController do
  use CheckboxesEx.Web, :controller

  alias CheckboxesEx.Color

  def index(conn, _params) do
    colors = Repo.all(Color)
    render(conn, "index.html", colors: colors)
  end

  def new(conn, _params) do
    changeset = Color.changeset(%Color{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"color" => color_params}) do
    changeset = Color.changeset(%Color{}, color_params)

    case Repo.insert(changeset) do
      {:ok, _color} ->
        conn
        |> put_flash(:info, "Color created successfully.")
        |> redirect(to: color_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    color = Repo.get!(Color, id)
    render(conn, "show.html", color: color)
  end

  def edit(conn, %{"id" => id}) do
    color = Repo.get!(Color, id)
    changeset = Color.changeset(color)
    render(conn, "edit.html", color: color, changeset: changeset)
  end

  def update(conn, %{"id" => id, "color" => color_params}) do
    color = Repo.get!(Color, id)
    changeset = Color.changeset(color, color_params)

    case Repo.update(changeset) do
      {:ok, color} ->
        conn
        |> put_flash(:info, "Color updated successfully.")
        |> redirect(to: color_path(conn, :show, color))
      {:error, changeset} ->
        render(conn, "edit.html", color: color, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    color = Repo.get!(Color, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(color)

    conn
    |> put_flash(:info, "Color deleted successfully.")
    |> redirect(to: color_path(conn, :index))
  end
end
