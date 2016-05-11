defmodule CheckboxesEx.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :price, :integer, null: false
      add :description, :text

      timestamps
    end
  end
end
