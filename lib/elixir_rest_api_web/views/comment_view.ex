defmodule ElixirRestApiWeb.CommentView do
  use ElixirRestApiWeb, :view
  alias ElixirRestApiWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      name: comment.name,
      comment_content: comment.comment_content}
  end
end
