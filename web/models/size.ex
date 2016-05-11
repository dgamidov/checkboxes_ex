defmodule CheckboxesEx.Size do
  use CheckboxesEx.Web, :model

  schema "sizes" do
    field :name, :string

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
    from c in query, order_by: c.id
  end

  def names_and_ids(query) do
    from c in query, select: {c.name, c.id}
  end

end
