defmodule CheckboxesEx.SizeController do
  use CheckboxesEx.Web, :controller

  alias CheckboxesEx.Size

  def index(conn, _params) do
    sizes = Repo.all(Size)
    render(conn, "index.html", sizes: sizes)
  end

  def new(conn, _params) do
    changeset = Size.changeset(%Size{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"size" => size_params}) do
    changeset = Size.changeset(%Size{}, size_params)

    case Repo.insert(changeset) do
      {:ok, _size} ->
        conn
        |> put_flash(:info, "Size created successfully.")
        |> redirect(to: size_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    size = Repo.get!(Size, id)
    render(conn, "show.html", size: size)
  end

  def edit(conn, %{"id" => id}) do
    size = Repo.get!(Size, id)
    changeset = Size.changeset(size)
    render(conn, "edit.html", size: size, changeset: changeset)
  end

  def update(conn, %{"id" => id, "size" => size_params}) do
    size = Repo.get!(Size, id)
    changeset = Size.changeset(size, size_params)

    case Repo.update(changeset) do
      {:ok, size} ->
        conn
        |> put_flash(:info, "Size updated successfully.")
        |> redirect(to: size_path(conn, :show, size))
      {:error, changeset} ->
        render(conn, "edit.html", size: size, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    size = Repo.get!(Size, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(size)

    conn
    |> put_flash(:info, "Size deleted successfully.")
    |> redirect(to: size_path(conn, :index))
  end
end
