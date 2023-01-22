defmodule CityfoodWeb.FoodTruckLive.Show do
  use CityfoodWeb, :live_view

  alias Cityfood.Food

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:food_truck, Food.get_food_truck!(id))}
  end

  defp page_title(:show), do: "Show Food truck"
  defp page_title(:edit), do: "Edit Food truck"
  def location2(location2)do
    Jason.encode!(location2)
  end
end
