defmodule ElixirRestApiWeb.DefaultController do
  use ElixirRestApiWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, JOSE.Poison.lexical_encode!(message()))
  end

  defp message do
    %{ status: "UP", database: "CONNECTED" }
  end
end