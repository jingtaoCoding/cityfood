defmodule Cityfood.Food.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cityfood.Cities.City

  schema "food_trucks" do
    field :dayofweekstr, :string
    field :dayorder, :string
    field :starttime, :string
    field :endtime, :string
    field :permit, :string
    field :location, :string
    field :locationdesc, :string
    field :optionaltext, :string
    field :locationid, :string
    field :start24, :string
    field :end24, :string
    field :cnn, :string
    field :block, :string
    field :lot, :string
    field :coldtruck, :string
    field :applicant, :string
    field :x, :string
    field :y, :string
    field :latitude, :string
    field :longitude, :string
    field :location_2, :map

    belongs_to :city, City

    timestamps()
  end

  @doc false

  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [
      :city_id,
      :dayorder,
      :dayofweekstr,
      :starttime,
      :endtime,
      :permit,
      :location,
      :locationdesc,
      :optionaltext,
      :locationid,
      :start24,
      :end24,
      :cnn,
      :block,
      :lot,
      :coldtruck,
      :applicant,
      :x,
      :y,
      :latitude,
      :longitude,
      :location_2
    ])
    |> IO.inspect()
    |> cast_location_2(attrs)
    |> IO.inspect()
    |> validate_required([
      # :city_id,
      :locationid,
      :coldtruck,
      :applicant,
      :x,
      :y,
      :latitude,
      :longitude
    ])
  end

  defp cast_location_2(changeset, attrs) do
    loc2 = attrs["location_2"]

    location_2 =
      %{
        human_address: loc2["human_address"],
        latitude: loc2["latitude"],
        longitude: loc2["longitude"]
      }
      |> IO.inspect()

    put_change(changeset, :location_2, location_2)
  end
end
