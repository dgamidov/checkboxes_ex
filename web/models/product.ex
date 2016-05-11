defmodule CheckboxesEx.Product do
  use CheckboxesEx.Web, :model

  schema "products" do
    field :name, :string
    field :price, :integer
    field :description, :string
    many_to_many :colors, CheckboxesEx.Color, join_through: CheckboxesEx.ProductColor, join_keys: [product_id: :id, parameter_id: :id], on_delete: :delete_all
    many_to_many :sizes, CheckboxesEx.Size, join_through: "products_sizes", join_keys: [product_id: :id, parameter_id: :id], on_delete: :delete_all

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :price, :description])
    |> validate_required([:name, :price])
    |> cast_assoc(:colors)
    |> cast_assoc(:sizes)
  end
end
