defmodule ElixirRestApiWeb.RegistrationView do
  use ElixirRestApiWeb, :view

  def render("success.json", %{user: user}) do
    %{
      status: :ok,
      message: """
        Now you are able to sign in using the email and password provided on route /api/users/signin.
        You will receive a JWT token to insert in Authorization header.
"""
    }
  end
end