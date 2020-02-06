defmodule ElixirRestApiWeb.DefaultController do
  use ElixirRestApiWeb, :controller

  def index(conn, _params) do
    text conn, "Up and running!"
  end
end