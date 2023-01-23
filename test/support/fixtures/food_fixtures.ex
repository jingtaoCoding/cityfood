defmodule Cityfood.FoodFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cityfood.Food` context.
  """

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    city = Cityfood.CitiesFixtures.city_fixture()

    {:ok, food_truck} =
      attrs
      |> Enum.into(%{
        city_id: city.id,
        dayofweekstr: "some dayofweekstr",
        dayorder: "some dayorder",
        locationid: "sdfsf",
        coldtruck: "Y",
        applicant: "someone",
        x: "x",
        y: "y",
        latitude: "32.3",
        longitude: "43",
        location_2: %{ human_address: nil,
                latitude: nil,
                longitude: nil
              }
      })
      |> Cityfood.Food.create_food_truck()

    food_truck
  end
end
