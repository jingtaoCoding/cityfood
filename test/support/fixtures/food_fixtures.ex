defmodule Cityfood.FoodFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cityfood.Food` context.
  """

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    {:ok, food_truck} =
      attrs
      |> Enum.into(%{
        dayofweekstr: "some dayofweekstr",
        dayorder: "some dayorder"
      })
      |> Cityfood.Food.create_food_truck()

    food_truck
  end
end
