# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirRestApi.Repo.insert!(%ElixirRestApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ElixirRestApi.Repo
alias ElixirRestApi.Accounts.User

Repo.insert!(User.changeset(%User{}, %{email: "user1@gmail.com", password: "administrator", claims: ["admin", "user"]}))