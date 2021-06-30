defmodule ElxproK8sWeb.Router do
  use ElxproK8sWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ElxproK8sWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElxproK8sWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/cars", CarLive.Index, :index
    live "/cars/new", CarLive.Index, :new
    live "/cars/:id/edit", CarLive.Index, :edit

    live "/cars/:id", CarLive.Show, :show
    live "/cars/:id/show/edit", CarLive.Show, :edit

    live "/categories", CategoryLive.Index, :index
    live "/categories/new", CategoryLive.Index, :new
    live "/categories/:id/edit", CategoryLive.Index, :edit

    live "/categories/:id", CategoryLive.Show, :show
    live "/categories/:id/show/edit", CategoryLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", ElxproK8sWeb do
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
      live_dashboard "/dashboard", metrics: ElxproK8sWeb.Telemetry
    end
  end
end
