defmodule CheckboxesEx.Repo.Migrations.CreateColor do
  use Ecto.Migration

  def change do
    create table(:colors) do
      add :name, :string, null: false

      timestamps
    end
    create unique_index(:colors, [:name])

  end
end
