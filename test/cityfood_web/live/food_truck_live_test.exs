defmodule CityfoodWeb.FoodTruckLiveTest do
  use CityfoodWeb.ConnCase

  import Phoenix.LiveViewTest
  import Cityfood.FoodFixtures
  import Cityfood.CitiesFixtures

  @create_attrs %{city_id: 1, locationid: "123", applicant: "applicant"}
  @update_attrs %{city_id: 1, locationid: "456", applicant: "applicant-updated"}
  @invalid_attrs %{locationid: nil, applicant: nil}

  defp create_food_truck(_) do
    city = city_fixture(%{name: "San Francisco"})
    food_truck = food_truck_fixture(%{city_id: city.id})
    %{food_truck: food_truck}
  end

  describe "Index" do
    setup [:create_food_truck]

    test "lists all food_trucks", %{conn: conn, food_truck: food_truck} do
      {:ok, _index_live, html} = live(conn, Routes.food_truck_index_path(conn, :index))

      assert html =~ "Listing Food trucks"
      assert html =~ food_truck.dayofweekstr
    end

    test "saves new food_truck", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.food_truck_index_path(conn, :index))

      assert index_live |> element("a", "New Food truck") |> render_click() =~
               "New Food truck"

      assert_patch(index_live, Routes.food_truck_index_path(conn, :new))

      assert index_live
             |> form("#food_truck-form", food_truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#food_truck-form", food_truck: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.food_truck_index_path(conn, :index))

      assert html =~ "Food truck created successfully"
      assert html =~ "some dayofweekstr"
    end

    test "updates food_truck in listing", %{conn: conn, food_truck: food_truck} do
      {:ok, index_live, _html} = live(conn, Routes.food_truck_index_path(conn, :index))

      assert index_live |> element("#food_truck-#{food_truck.id} a", "Edit") |> render_click() =~
               "Edit Food truck"

      assert_patch(index_live, Routes.food_truck_index_path(conn, :edit, food_truck))

      assert index_live
             |> form("#food_truck-form", food_truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#food_truck-form", food_truck: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.food_truck_index_path(conn, :index))

      assert html =~ "Food truck updated successfully"
      assert html =~ "applicant-updated"
    end

    test "deletes food_truck in listing", %{conn: conn, food_truck: food_truck} do
      {:ok, index_live, _html} = live(conn, Routes.food_truck_index_path(conn, :index))

      assert index_live |> element("#food_truck-#{food_truck.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#food_truck-#{food_truck.id}")
    end
  end

  describe "Show" do
    setup [:create_food_truck]

    test "displays food_truck", %{conn: conn, food_truck: food_truck} do
      {:ok, _show_live, html} = live(conn, Routes.food_truck_show_path(conn, :show, food_truck))

      assert html =~ "Show Food truck"
      assert html =~ food_truck.dayofweekstr
    end

    test "updates food_truck within modal", %{conn: conn, food_truck: food_truck} do
      {:ok, show_live, _html} = live(conn, Routes.food_truck_show_path(conn, :show, food_truck))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Food truck"

      assert_patch(show_live, Routes.food_truck_show_path(conn, :edit, food_truck))

      assert show_live
             |> form("#food_truck-form", food_truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#food_truck-form", food_truck: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.food_truck_show_path(conn, :show, food_truck))

      assert html =~ "Food truck updated successfully"
      assert html =~ "456"
    end
  end
end
