defmodule CityfoodWeb.CityLive.Index do
  use CityfoodWeb, :live_view

  alias Cityfood.Cities
  alias Cityfood.Cities.City

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :cities, list_cities())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit City")
    |> assign(:city, Cities.get_city!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New City")
    |> assign(:city, %City{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cities")
    |> assign(:city, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    city = Cities.get_city!(id)
    {:ok, _} = Cities.delete_city(city)

    {:noreply, assign(socket, :cities, list_cities())}
  end

  defp list_cities do
    Cities.list_cities()
  end
end
