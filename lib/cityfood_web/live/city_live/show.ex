defmodule CityfoodWeb.CityLive.Show do
  use CityfoodWeb, :live_view

  alias Cityfood.Cities

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:city, Cities.get_city!(id))}
  end

  defp page_title(:show), do: "Show City"
  defp page_title(:edit), do: "Edit City"
end
