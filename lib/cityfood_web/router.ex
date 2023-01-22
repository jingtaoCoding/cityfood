defmodule CityfoodWeb.Router do
  use CityfoodWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CityfoodWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CityfoodWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/cities", CityLive.Index, :index
    live "/cities/new", CityLive.Index, :new
    live "/cities/:id/edit", CityLive.Index, :edit
    live "/cities/:id", CityLive.Show, :show
    live "/cities/:id/show/edit", CityLive.Show, :edit

    live "/food_trucks", FoodTruckLive.Index, :index
    live "/food_trucks/new", FoodTruckLive.Index, :new
    live "/food_trucks/:id/edit", FoodTruckLive.Index, :edit

    live "/food_trucks/:id", FoodTruckLive.Show, :show
    live "/food_trucks/:id/show/edit", FoodTruckLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", CityfoodWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CityfoodWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
