defmodule Cityfood.Food do
  @moduledoc """
  The Food context.
  """

  import Ecto.Query, warn: false
  alias Cityfood.Repo

  alias Cityfood.Food.FoodTruck

  @doc """
  Returns the list of food_trucks.

  ## Examples

      iex> list_food_trucks()
      [%FoodTruck{}, ...]

  """
  def list_food_trucks do
    Repo.all(FoodTruck)
  end

  def search_food_trucks_by_food(food) do
    like_query = "%#{food}%"

    FoodTruck
    |> where([ft], ilike(ft.optionaltext, ^like_query))
    |> Repo.all()
  end

  def list_food_trucks_with_filters(filters) do
    FoodTruck
    |> filter_by_city(filters)
    |> filter_by_coldtruck(filters)
    |> filter_by_dayofweekstr(filters)
    |> Repo.all()
  end

  defp filter_by_city(query, %{city_id: city_id}),
    do: where(query, [ft], ft.city_id == ^city_id)

  defp filter_by_city(query, _), do: query

  defp filter_by_coldtruck(query, %{city_id: city_id, coldtruck: coldtruck}) do
    query
    |> where([ft], ft.city_id == ^city_id)
    |> where([ft], ft.coldtruck == ^coldtruck)
  end

  defp filter_by_coldtruck(query, _), do: query

  defp filter_by_dayofweekstr(query, %{dayofweekstr: dayofweekstr}),
    do: where(query, [ft], ft.dayofweekstr == ^dayofweekstr)

  defp filter_by_dayofweekstr(query, _), do: query

  @doc """
  Gets a single food_truck.

  Raises `Ecto.NoResultsError` if the Food truck does not exist.

  ## Examples

      iex> get_food_truck!(123)
      %FoodTruck{}

      iex> get_food_truck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_truck!(id), do: Repo.get!(FoodTruck, id)

  @doc """
  Creates a food_truck.

  ## Examples

      iex> create_food_truck(%{field: value})
      {:ok, %FoodTruck{}}

      iex> create_food_truck(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_truck(attrs \\ %{}) do
    %FoodTruck{}
    |> FoodTruck.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update or create a new record
  """
  def upsert_food_truck(%{"locationid" => locationid, "dayorder" => dayorder} = attrs) do
    conflict_target = [:locationid, :dayorder]
    on_conflict_changes = [updated_at: DateTime.utc_now()]

    on_conflict =
      FoodTruck
      |> where([f], f.locationid == ^locationid and f.dayorder == ^dayorder)
      |> update(set: ^on_conflict_changes)

    food_truck =
      %FoodTruck{}
      |> FoodTruck.changeset(attrs)
      |> Repo.insert!(
        on_conflict: on_conflict,
        conflict_target: conflict_target,
        returning: true
      )

    {:ok, food_truck}
  end

  @doc """
  Updates a food_truck.

  ## Examples

      iex> update_food_truck(food_truck, %{field: new_value})
      {:ok, %FoodTruck{}}

      iex> update_food_truck(food_truck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_truck(%FoodTruck{} = food_truck, attrs) do
    food_truck
    |> FoodTruck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_truck.

  ## Examples

      iex> delete_food_truck(food_truck)
      {:ok, %FoodTruck{}}

      iex> delete_food_truck(food_truck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_truck(%FoodTruck{} = food_truck) do
    Repo.delete(food_truck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_truck changes.

  ## Examples

      iex> change_food_truck(food_truck)
      %Ecto.Changeset{data: %FoodTruck{}}

  """
  def change_food_truck(%FoodTruck{} = food_truck, attrs \\ %{}) do
    FoodTruck.changeset(food_truck, attrs)
  end
end
