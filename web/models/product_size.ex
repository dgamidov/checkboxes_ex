defmodule CheckboxesEx.ProductSize do
  use CheckboxesEx.Web, :model

  @primary_key {:id, :id, autogenerate: false}

  schema "products_sizes" do
    belongs_to :product, CheckboxesEx.Product
    belongs_to :size, CheckboxesEx.Size, foreign_key: :parameter_id
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:product_id, :parameter_id])
    |> validate_required([:product_id, :parameter_id])
    |> unique_constraint(:product_id, :parameter_id)
  end
 
end
