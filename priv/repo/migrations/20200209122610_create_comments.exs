defmodule ElixirRestApi.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :name, :string
      add :comment_content, :text

      timestamps()
    end

  end
end
