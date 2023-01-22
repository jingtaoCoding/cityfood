defmodule Cityfood.CitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cityfood.Cities` context.
  """

  @doc """
  Generate a city.
  """
  def city_fixture(attrs \\ %{}) do
    {:ok, city} =
      attrs
      |> Enum.into(%{
        country: "some country",
        name: "some name"
      })
      |> Cityfood.Cities.create_city()

    city
  end
end
