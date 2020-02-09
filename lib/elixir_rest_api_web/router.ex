defmodule ElixirRestApiWeb.Router do
  use ElixirRestApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ElixirRestApiWeb.Auth.Pipeline
  end

  scope "/auth", ElixirRestApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  scope "/api", ElixirRestApiWeb do
    pipe_through [:api, :auth]
    get "/content/posts/:id", PostController, :get_post
    resources "/comments", CommentController, except: [:new, :edit]
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", ElixirRestApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
