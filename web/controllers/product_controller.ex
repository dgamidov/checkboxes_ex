defmodule CheckboxesEx.ProductController do
  use CheckboxesEx.Web, :controller

  alias CheckboxesEx.{Product, Color, Size, ProductColor, ProductSize}

  plug :load_colors     when action in [:new, :create, :edit, :update]
  plug :load_sizes      when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    products = Repo.all(Product)
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Product.changeset(%Product{})
    render(conn, "new.html", changeset: changeset,
                             product_colors_ids: [],
                             product_sizes_ids: [])
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    checked_colors_ids = checked_ids(conn, "checked_colors")
    checked_sizes_ids = checked_ids(conn, "checked_sizes")

    case Repo.insert(changeset) do
      {:ok, product} ->
        product_id = product.id
        do_update_intermediate_table(ProductColor, product_id, [], checked_colors_ids)
        do_update_intermediate_table(ProductSize, product_id, [], checked_sizes_ids)
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    product = Repo.preload product, [:colors, :sizes]
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)    
    product = Repo.preload product, [:colors, :sizes]
    
    product_colors_ids = product.colors |> Enum.map(&(&1.id))
    product_sizes_ids = product.sizes |> Enum.map(&(&1.id))

    changeset = Product.changeset(product)
    render(conn, "edit.html", product: product, changeset: changeset, 
                              product_colors_ids: product_colors_ids,
                              product_sizes_ids: product_sizes_ids)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get!(Product, id)
    product = Repo.preload product, [:colors, :sizes]

    product_colors_ids = product.colors |> Enum.map(&(&1.id))
    product_sizes_ids = product.sizes |> Enum.map(&(&1.id))

    changeset = Product.changeset(product, product_params)
    
    product_id = product.id

    checked_colors_ids = checked_ids(conn, "checked_colors")
    checked_sizes_ids = checked_ids(conn, "checked_sizes")

    case Repo.update(changeset) do
      {:ok, product} ->
        do_update_intermediate_table(ProductColor, product_id, product_colors_ids, checked_colors_ids)
        do_update_intermediate_table(ProductSize, product_id, product_sizes_ids, checked_sizes_ids)
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  defp checked_ids(conn, checked_list) do
    conn.params[checked_list]
    |> filter_true_checkbox
  end
  
  defp filter_true_checkbox(checkbox_list) do
    checkbox_list
    |> Enum.map(&(do_get_id_if_true(&1)))
    |> Enum.filter(&(&1 != nil))
  end
  
  defp do_get_id_if_true(tuple) do
    case tuple do
      {id, "true"} -> String.to_integer id
      _ -> nil
    end
  end

  defp do_update_intermediate_table(model, product_id, list_of_existing_ids, list_of_checked_ids) do
    ids_to_delete = list_of_existing_ids -- list_of_checked_ids
    ids_to_insert = (list_of_checked_ids -- list_of_existing_ids) -- ids_to_delete

    if length(ids_to_delete) > 0 do
      query = from c in model, where: c.product_id == ^product_id and c.parameter_id in ^ids_to_delete
      Repo.delete_all query
    end

    if length(ids_to_insert) > 0 do
      data = ids_to_insert |> Enum.map(&([product_id: product_id, parameter_id: &1]))
      Repo.insert_all model, data
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end
  
  defp load_colors(conn, _) do
    query =
      Color
      |> Color.alphabetical
      |> Color.names_and_ids
    colors = Repo.all query
    assign(conn, :colors, colors)
  end

  defp load_sizes(conn, _) do
    query =
      Size
      |> Size.alphabetical
      |> Size.names_and_ids
    sizes = Repo.all query
    assign(conn, :sizes, sizes)
  end
  
end
