defmodule CityfoodWeb.FoodTruckLive.FormComponent do
  use CityfoodWeb, :live_component

  alias Cityfood.Food

  @impl true
  def update(%{food_truck: food_truck} = assigns, socket) do
    changeset = Food.change_food_truck(food_truck)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"food_truck" => food_truck_params}, socket) do
    changeset =
      socket.assigns.food_truck
      |> Food.change_food_truck(food_truck_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"food_truck" => food_truck_params}, socket) do
    save_food_truck(socket, socket.assigns.action, food_truck_params)
  end

  defp save_food_truck(socket, :edit, food_truck_params) do
    case Food.update_food_truck(socket.assigns.food_truck, food_truck_params) do
      {:ok, _food_truck} ->
        {:noreply,
         socket
         |> put_flash(:info, "Food truck updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_food_truck(socket, :new, food_truck_params) do
    case Food.create_food_truck(food_truck_params) do
      {:ok, _food_truck} ->
        {:noreply,
         socket
         |> put_flash(:info, "Food truck created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
