defmodule MovieWeb.FavoriteControllerTest do
  use MovieWeb.ConnCase

  import Movie.CoreFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all favorites", %{conn: conn} do
      conn = get(conn, ~p"/api/favorites?user_id=1")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create favorite" do
    test "renders favorite when data is valid", %{conn: conn} do
      user = user_fixture()
      content = content_fixture()

      conn =
        post(conn, ~p"/api/favorites",
          favorite: %{
            user_id: user.id,
            content_id: content.id
          }
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/favorites/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, ~p"/api/favorites",
          favorite: %{
            "content_id" => 1,
            "user_id" => 1
          }
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete favorite" do
    setup [:create_favorite]

    test "deletes chosen favorite", %{conn: conn, favorite: favorite} do
      conn = delete(conn, ~p"/api/favorites/#{favorite}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/favorites/#{favorite}")
      end
    end
  end

  defp create_favorite(_) do
    favorite = favorite_fixture()
    %{favorite: favorite}
  end
end
