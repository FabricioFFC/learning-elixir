defmodule GeolocationServiceWeb.Router do
  use GeolocationServiceWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", GeolocationServiceWeb do
    pipe_through(:api)

    get("/geolocations/:ip_address", GeolocationController, :show)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Mix.env() in [:dev, :test] do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: GeolocationServiceWeb.Telemetry)
    end
  end
end
