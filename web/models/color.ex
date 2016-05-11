defmodule CheckboxesEx.Color do
  use CheckboxesEx.Web, :model

  schema "colors" do
    field :name, :string
    many_to_many :products, CheckboxesEx.Product, join_through: CheckboxesEx.ProductColor

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
  
  def alphabetical(query) do
    from c in query, order_by: c.name
  end

  def names_and_ids(query) do
    from c in query, select: {c.name, c.id}
  end

end
