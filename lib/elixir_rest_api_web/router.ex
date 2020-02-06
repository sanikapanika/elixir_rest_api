defmodule ElixirRestApiWeb.Router do
  use ElixirRestApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirRestApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", ElixirRestApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
