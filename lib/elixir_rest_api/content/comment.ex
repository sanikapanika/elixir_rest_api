defmodule ElixirRestApi.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :comment_content, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name, :comment_content])
    |> validate_required([:name, :comment_content])
  end
end
