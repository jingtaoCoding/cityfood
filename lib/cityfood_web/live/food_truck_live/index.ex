defmodule CityfoodWeb.FoodTruckLive.Index do
  use CityfoodWeb, :live_view

  alias Cityfood.Food
  alias Cityfood.Food.FoodTruck

  @impl true
  def mount(_params, _session, socket) do
    food_trucks = Food.list_food_trucks()
    # food_trucks =[]
    key = Application.get_env(:geocoder, :worker)[:key]

    {:ok,
     socket
     |> assign(:food_trucks, food_trucks)
     |> assign(:view, "map_view")
     |> assign(:key, key)}
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

  @impl true
  def handle_event("change-view", %{"view" => view}, socket) do
    {:noreply, assign(socket, :view, view)}
  end

  defp list_food_trucks do
    Food.list_food_trucks()
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
end
