defmodule ElixirRestApiWeb.Accounts do
  import Ecto.Query, warn: false

  alias ElixirRestApi.Repo
  alias ElixirRestApi.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user -> {:ok, user}
    end
  end
end