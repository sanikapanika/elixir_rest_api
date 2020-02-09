defmodule ElixirRestApi.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :name, :string
    field :post_content, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :post_content])
    |> validate_required([:name, :post_content])
    |> unique_constraint(:id)
  end
end
