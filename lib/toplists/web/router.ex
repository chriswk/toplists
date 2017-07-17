defmodule Toplists.Web.Router do
  use Toplists.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Toplists.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/people", PersonController
    resources "/countries", CountryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Toplists.Web do
  #   pipe_through :api
  # end
end
