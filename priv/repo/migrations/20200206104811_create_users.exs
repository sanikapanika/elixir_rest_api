defmodule ElixirRestApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :encrypted_password, :string
      add :claims, {:array, :string}

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
