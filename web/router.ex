defmodule CheckboxesEx.Router do
  use CheckboxesEx.Web, :router

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

  scope "/", CheckboxesEx do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/colors", ColorController
    resources "/sizes", SizeController
    resources "/products", ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CheckboxesEx do
  #   pipe_through :api
  # end
end
