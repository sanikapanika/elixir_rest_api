defmodule ElixirRestApiWeb.CommentController do
  use ElixirRestApiWeb, :controller

  alias ElixirRestApi.Content
  alias ElixirRestApi.Content.Comment

  action_fallback ElixirRestApiWeb.FallbackController

  def index(conn, _params) do
    comments = Content.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Content.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
      |> render("show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Content.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Content.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)

    with {:ok, %Comment{}} <- Content.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
