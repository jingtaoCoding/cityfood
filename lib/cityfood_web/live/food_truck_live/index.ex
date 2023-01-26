defmodule CityfoodWeb.FoodTruckLive.Index do
  use CityfoodWeb, :live_view
  alias CityFood.Utils
  alias Cityfood.Cities
  alias Cityfood.Food
  alias Cityfood.Food.FoodTruck

  @cols [
    {"locationid", "Location ID"},
    {"coldtruck", "Cold Truck"},
    {"dayofweekstr", "Day of Week"},
    {"starttime", "Start Time"},
    {"endtime", "End Time"},
    {"location", "Location"},
    {"locationdesc", "Location Desc"},
    {"optionaltext", "Optional Text"},
    {"block", "Block"},
    {"applicant", "Applicant"}
  ]
  @default_city "San Francisco"
  @filters %{city: @default_city, dayofweekstr: "", coldtruck: ""}
  @impl true
  def mount(_params, _session, socket) do
    city = Cities.get_city_by_name!(@default_city)
    cities = if connected?(socket), do: Cities.list_cities(), else: []
    food_trucks = if connected?(socket), do: list_food_trucks(), else: []

    socket =
      socket
      |> assign(:city, city)
      |> assign(:cities, cities)
      |> assign(:food_trucks, food_trucks)
      |> assign(:view, "list_view")
      |> assign(:cols, @cols)
      |> assign(:filters, @filters)
      |> assign(:food, "")
      |> assign(:loading, false)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Food truck")
    |> assign(:food_truck, Food.get_food_truck!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Food truck")
    |> assign(:food_truck, %FoodTruck{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Food trucks")
    |> assign(:food_truck, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    food_truck = Food.get_food_truck!(id)
    {:ok, _} = Food.delete_food_truck(food_truck)

    {:noreply, assign(socket, :food_trucks, list_food_trucks())}
  end

  def handle_event("change-view", %{"view" => view}, socket) do
    {:noreply, assign(socket, :view, view)}
  end

  def handle_event("filters", params, socket) do
    {_target, params} = Map.pop(params, "_target")
    filters = Map.merge(socket.assigns.filters, params |> Utils.atom_map())
    city = Cities.get_city_by_name!(filters.city)
    params = filters |> Map.put(:city_id, city.id) |> Utils.compact()

    case list_food_trucks_with_filters(params) do
      [] ->
        socket =
          socket
          |> clear_flash()
          |> put_flash(:info, "No food-truck matching \"#{Jason.encode!(filters)}\"")
          |> assign(:filters, filters)
          |> assign(:city, city)
          |> assign(:food_trucks, [])

        {:noreply, socket}

      food_trucks ->
        socket =
          socket
          |> clear_flash()
          |> assign(:filters, filters)
          |> assign(:city, city)
          |> assign(:food_trucks, food_trucks)

        {:noreply, socket}
    end
  end

  def handle_event("clear", params, socket) do
    food_trucks = list_food_trucks()

    socket =
      socket
      |> clear_flash()
      |> assign(:filters, @filters)
      |> assign(:food_trucks, food_trucks)

    {:noreply, socket}
  end

  def handle_event("food-search", %{"food" => food}, socket) do
    send(self(), {:run_food_search, food})

    socket =
      socket
      |> clear_flash()
      |> assign(food: food, loading: true)

    {:noreply, socket}
  end

  def handle_info({:run_food_search, food}, socket) do
    case Food.search_food_trucks_by_food(food) do
      [] ->
        socket =
          socket
          |> clear_flash()
          |> put_flash(:info, "No food-truck matching \"#{food}\"")
          |> assign(food_trucks: [], loading: false)

        {:noreply, socket}

      food_trucks ->
        socket = assign(socket, food_trucks: food_trucks, loading: false)
        {:noreply, socket}
    end
  end

  defp list_food_trucks do
    Food.list_food_trucks()
  end

  defp list_food_trucks_with_filters(filters) do
    Food.list_food_trucks_with_filters(filters)
  end

  def show(target_view, current_view) do
    case target_view do
      ^current_view -> "visible"
      _ -> "hidden"
    end
  end

  def format(data_list) do
    data_list
    |> Enum.map(
      &(&1
        |> Map.from_struct()
        |> Map.take([
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
        ]))
    )
    |> Jason.encode!()
  end

  def encode(city) do
    city |> Map.from_struct() |> Map.delete(:__meta__) |> Jason.encode!()
  end

  def map_api_src do
    api_key = Application.get_env(:cityfood, :google_map)[:api_key]
    "https://maps.googleapis.com/maps/api/js?key=#{api_key}&callback=initMap&v=weekly"
  end
end
