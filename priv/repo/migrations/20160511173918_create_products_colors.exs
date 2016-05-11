defmodule CheckboxesEx.Repo.Migrations.CreateProductsColors do
  use Ecto.Migration

  def change do
    create table(:products_colors, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :parameter_id, references(:colors, on_delete: :delete_all)
    end

    create index(:products_colors, [:product_id])
    create index(:products_colors, [:parameter_id])
    create unique_index(:products_colors, [:product_id, :parameter_id])    
  end
end
