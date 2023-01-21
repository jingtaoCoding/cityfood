defmodule CityfoodWeb.PageController do
  use CityfoodWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
