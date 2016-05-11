defmodule CheckboxesEx.Repo.Migrations.CreateProductsSizes do
  use Ecto.Migration

  def change do
    create table(:products_sizes, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :parameter_id, references(:sizes, on_delete: :delete_all)
    end

    create index(:products_sizes, [:product_id])
    create index(:products_sizes, [:parameter_id])
    create unique_index(:products_sizes, [:product_id, :parameter_id])
  end
end
