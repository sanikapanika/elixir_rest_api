defmodule ElixirRestApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :post_content, :text

      timestamps()
    end

    create unique_index(:posts, [:id])
  end
end
