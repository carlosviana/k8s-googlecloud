defmodule ElxproK8sWeb.CarLiveTest do
  use ElxproK8sWeb.ConnCase

  import Phoenix.LiveViewTest

  alias ElxproK8s.Cars

  @create_attrs %{brand: "some brand", description: "some description", license_plate: "some license_plate"}
  @update_attrs %{brand: "some updated brand", description: "some updated description", license_plate: "some updated license_plate"}
  @invalid_attrs %{brand: nil, description: nil, license_plate: nil}

  defp fixture(:car) do
    {:ok, car} = Cars.create_car(@create_attrs)
    car
  end

  defp create_car(_) do
    car = fixture(:car)
    %{car: car}
  end

  describe "Index" do
    setup [:create_car]

    test "lists all cars", %{conn: conn, car: car} do
      {:ok, _index_live, html} = live(conn, Routes.car_index_path(conn, :index))

      assert html =~ "Listing Cars"
      assert html =~ car.brand
    end

    test "saves new car", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.car_index_path(conn, :index))

      assert index_live |> element("a", "New Car") |> render_click() =~
               "New Car"

      assert_patch(index_live, Routes.car_index_path(conn, :new))

      assert index_live
             |> form("#car-form", car: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#car-form", car: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.car_index_path(conn, :index))

      assert html =~ "Car created successfully"
      assert html =~ "some brand"
    end

    test "updates car in listing", %{conn: conn, car: car} do
      {:ok, index_live, _html} = live(conn, Routes.car_index_path(conn, :index))

      assert index_live |> element("#car-#{car.id} a", "Edit") |> render_click() =~
               "Edit Car"

      assert_patch(index_live, Routes.car_index_path(conn, :edit, car))

      assert index_live
             |> form("#car-form", car: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#car-form", car: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.car_index_path(conn, :index))

      assert html =~ "Car updated successfully"
      assert html =~ "some updated brand"
    end

    test "deletes car in listing", %{conn: conn, car: car} do
      {:ok, index_live, _html} = live(conn, Routes.car_index_path(conn, :index))

      assert index_live |> element("#car-#{car.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#car-#{car.id}")
    end
  end

  describe "Show" do
    setup [:create_car]

    test "displays car", %{conn: conn, car: car} do
      {:ok, _show_live, html} = live(conn, Routes.car_show_path(conn, :show, car))

      assert html =~ "Show Car"
      assert html =~ car.brand
    end

    test "updates car within modal", %{conn: conn, car: car} do
      {:ok, show_live, _html} = live(conn, Routes.car_show_path(conn, :show, car))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Car"

      assert_patch(show_live, Routes.car_show_path(conn, :edit, car))

      assert show_live
             |> form("#car-form", car: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#car-form", car: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.car_show_path(conn, :show, car))

      assert html =~ "Car updated successfully"
      assert html =~ "some updated brand"
    end
  end
end
