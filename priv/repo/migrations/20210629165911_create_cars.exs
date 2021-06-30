defmodule ElxproK8s.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :brand, :string
      add :description, :string
      add :license_plate, :string
      add :category, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:cars, [:category])
  end
end
