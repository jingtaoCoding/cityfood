defmodule Cityfood.Cities.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :country, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :country])
    |> validate_required([:name, :country])
  end
end
