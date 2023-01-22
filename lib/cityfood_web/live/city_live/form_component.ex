defmodule CityfoodWeb.CityLive.FormComponent do
  use CityfoodWeb, :live_component

  alias Cityfood.Cities

  @impl true
  def update(%{city: city} = assigns, socket) do
    changeset = Cities.change_city(city)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"city" => city_params}, socket) do
    changeset =
      socket.assigns.city
      |> Cities.change_city(city_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"city" => city_params}, socket) do
    save_city(socket, socket.assigns.action, city_params)
  end

  defp save_city(socket, :edit, city_params) do
    case Cities.update_city(socket.assigns.city, city_params) do
      {:ok, _city} ->
        {:noreply,
         socket
         |> put_flash(:info, "City updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_city(socket, :new, city_params) do
    case Cities.create_city(city_params) do
      {:ok, _city} ->
        {:noreply,
         socket
         |> put_flash(:info, "City created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
