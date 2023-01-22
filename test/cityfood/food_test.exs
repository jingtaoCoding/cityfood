defmodule Cityfood.FoodTest do
  use Cityfood.DataCase

  alias Cityfood.Food

  describe "food_trucks" do
    alias Cityfood.Food.FoodTruck

    import Cityfood.FoodFixtures

    @invalid_attrs %{dayofweekstr: nil, dayorder: nil}

    test "list_food_trucks/0 returns all food_trucks" do
      food_truck = food_truck_fixture()
      assert Food.list_food_trucks() == [food_truck]
    end

    test "get_food_truck!/1 returns the food_truck with given id" do
      food_truck = food_truck_fixture()
      assert Food.get_food_truck!(food_truck.id) == food_truck
    end

    test "create_food_truck/1 with valid data creates a food_truck" do
      valid_attrs = %{dayofweekstr: "some dayofweekstr", dayorder: "some dayorder"}

      assert {:ok, %FoodTruck{} = food_truck} = Food.create_food_truck(valid_attrs)
      assert food_truck.dayofweekstr == "some dayofweekstr"
      assert food_truck.dayorder == "some dayorder"
    end

    test "create_food_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Food.create_food_truck(@invalid_attrs)
    end

    test "update_food_truck/2 with valid data updates the food_truck" do
      food_truck = food_truck_fixture()

      update_attrs = %{
        dayofweekstr: "some updated dayofweekstr",
        dayorder: "some updated dayorder"
      }

      assert {:ok, %FoodTruck{} = food_truck} = Food.update_food_truck(food_truck, update_attrs)
      assert food_truck.dayofweekstr == "some updated dayofweekstr"
      assert food_truck.dayorder == "some updated dayorder"
    end

    test "update_food_truck/2 with invalid data returns error changeset" do
      food_truck = food_truck_fixture()
      assert {:error, %Ecto.Changeset{}} = Food.update_food_truck(food_truck, @invalid_attrs)
      assert food_truck == Food.get_food_truck!(food_truck.id)
    end

    test "delete_food_truck/1 deletes the food_truck" do
      food_truck = food_truck_fixture()
      assert {:ok, %FoodTruck{}} = Food.delete_food_truck(food_truck)
      assert_raise Ecto.NoResultsError, fn -> Food.get_food_truck!(food_truck.id) end
    end

    test "change_food_truck/1 returns a food_truck changeset" do
      food_truck = food_truck_fixture()
      assert %Ecto.Changeset{} = Food.change_food_truck(food_truck)
    end
  end
end
