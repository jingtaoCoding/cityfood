# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cityfood.Repo.insert!(%Cityfood.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cityfood.{DataFetcher, Cities}

# Create some cities
cities = ["San Francisco", "San Mateo", "Sunnyvale", "Fremont", "Milpitas", "San Diego"]
Enum.map(cities, &Cities.create_city(%{name: &1, country: "USA"}))

# Feach food-trucks
DataFetcher.refresh_data()
