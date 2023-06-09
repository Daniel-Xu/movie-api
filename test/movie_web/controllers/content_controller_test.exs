defmodule MovieWeb.ContentControllerTest do
  use MovieWeb.ConnCase

  import Movie.CoreFixtures

  alias Movie.Core.Content

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all contents", %{conn: conn} do
      conn = get(conn, ~p"/api/contents")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create content" do
    test "renders content when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/contents", content: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/contents/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/contents", content: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update content" do
    setup [:create_content]

    test "renders content when data is valid", %{conn: conn, content: %Content{id: id} = content} do
      conn = put(conn, ~p"/api/contents/#{content}", content: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/contents/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, content: content} do
      conn = put(conn, ~p"/api/contents/#{content}", content: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete content" do
    setup [:create_content]

    test "deletes chosen content", %{conn: conn, content: content} do
      conn = delete(conn, ~p"/api/contents/#{content}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/contents/#{content}")
      end
    end
  end

  defp create_content(_) do
    content = content_fixture()
    %{content: content}
  end
end
