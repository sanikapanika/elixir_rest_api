defmodule ElixirRestApiWeb.PostControllerTest do
  use ElixirRestApiWeb.ConnCase

  alias ElixirRestApi.Content
  alias ElixirRestApi.Content.Post

  @create_attrs %{
    id: 42,
    name: "some name",
    post_content: "some post_content"
  }
  @update_attrs %{
    id: 43,
    name: "some updated name",
    post_content: "some updated post_content"
  }
  @invalid_attrs %{id: nil, name: nil, post_content: nil}

  def fixture(:post) do
    {:ok, post} = Content.create_post(@create_attrs)
    post
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.post_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post" do
    test "renders post when data is valid", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.post_path(conn, :show, id))

      assert %{
               "id" => id,
               "id" => 42,
               "name" => "some name",
               "post_content" => "some post_content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.post_path(conn, :create), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post" do
    setup [:create_post]

    test "renders post when data is valid", %{conn: conn, post: %Post{id: id} = post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.post_path(conn, :show, id))

      assert %{
               "id" => id,
               "id" => 43,
               "name" => "some updated name",
               "post_content" => "some updated post_content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put(conn, Routes.post_path(conn, :update, post), post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post" do
    setup [:create_post]

    test "deletes chosen post", %{conn: conn, post: post} do
      conn = delete(conn, Routes.post_path(conn, :delete, post))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_path(conn, :show, post))
      end
    end
  end

  defp create_post(_) do
    post = fixture(:post)
    {:ok, post: post}
  end
end
