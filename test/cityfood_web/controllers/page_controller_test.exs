defmodule CityfoodWeb.PageControllerTest do
  use CityfoodWeb.ConnCase

  test "GET /pages", %{conn: conn} do
    conn = get(conn, "/pages")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
