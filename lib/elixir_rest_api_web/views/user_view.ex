defmodule ElixirRestApiWeb.UserView do
  use ElixirRestApiWeb, :view
  alias ElixirRestApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token, claims: claims}) do
    %{id: user.id,
      email: user.email,
      token: token,
      claims: claims}
  end
end
