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
cities = [
  {"San Francisco", 37.773972, -122.431297},
  {"Sunnyvale", 37.368832, -122.036346},
  {"Fremont", 37.5482697, -121.98857190000001},
  {"Milpitas", 37.432334, -121.899574},
  {"San Jose", 37.342205, -121.851990}
]

Enum.map(cities, fn {name, lan, lon} ->
  Cities.create_city(%{name: name, lan: lan, lon: lon, country: "USA"})
end)

# Feach food-trucks
DataFetcher.refresh_data()
