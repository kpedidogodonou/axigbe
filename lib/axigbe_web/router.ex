defmodule AxigbeWeb.Router do
  # alias Hex.API.Auth
  use AxigbeWeb, :router

  use AshAuthentication.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AxigbeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug :load_from_session
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug :load_from_bearer
  end

  scope "/", AxigbeWeb do
    pipe_through :browser


    sign_in_route(
      register_path: "/register",
    reset_path: "/reset",
    overrides: [
      AxigbeWeb.Auth.Overrides,
      AshAuthentication.Phoenix.Overrides.Default
    ],
    on_mount: [{AxigbeWeb.LiveUserAuth, :live_no_user}])



    sign_out_route AuthController
    auth_routes_for Axigbe.Accounts.User, to: AuthController
    # reset_route []
    reset_route(layout: {AxigbeWeb, :livek})


    ash_authentication_live_session :authentication_required,
      on_mount: {AxigbeWeb.LiveUserAuth, :live_user_required} do
        # live "/protected_route"
      end
      
    ash_authentication_live_session :authentication_optional,
    on_mount: {AxigbeWeb.LiveUserAuth, :live_user_optional} do
      # live "/protected_route"
      live "/", LiveHome

      end
    end




  # Other scopes may use custom stacks.
  # scope "/api", AxigbeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:axigbe, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AxigbeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
