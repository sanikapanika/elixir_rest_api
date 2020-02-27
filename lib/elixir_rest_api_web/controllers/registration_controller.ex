defmodule ElixirRestApiWeb.RegistrationController do
  use ElixirRestApiWeb, :controller

  alias ElixirRestApi.Accounts.User
  alias ElixirRestApi.Repo

  def sign_up(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("success.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElixirRestApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end