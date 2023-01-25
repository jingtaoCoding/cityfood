defmodule Cityfood.DataFetcher do
  alias Cityfood.{Food, Cities}

  @url_sf_mobile_food_data_2023 "https://data.sfgov.org/resource/jjew-r69b.json"
  def get(url \\ @url_sf_mobile_food_data_2023) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> Jason.decode!(body)
      {:ok, response} -> {:error, response}
    end
  end

  @sf_city "San Francisco"
  def refresh_data do
    city = Cities.get_city_by_name!(@sf_city)
    data = get()

    trucks = Enum.map(data, &(&1 |> Map.put("city_id", city.id) |> Food.create_food_truck()))
  end
end
