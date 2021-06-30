defmodule ElxproK8s.Cars.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    field :brand, :string
    field :description, :string
    field :license_plate, :string
    field :category, :id

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:brand, :description, :license_plate])
    |> validate_required([:brand, :description, :license_plate])
  end
end
