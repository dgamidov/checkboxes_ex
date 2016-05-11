defmodule CheckboxesEx.Repo.Migrations.CreateSize do
  use Ecto.Migration

  def change do
    create table(:sizes) do
      add :name, :string, null: false

      timestamps
    end
    create unique_index(:sizes, [:name])

  end
end
