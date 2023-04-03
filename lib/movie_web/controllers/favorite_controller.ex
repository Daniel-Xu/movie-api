defmodule MovieWeb.FavoriteController do
  use MovieWeb, :controller

  alias Movie.Core
  alias Movie.Core.{User, Favorite, Content}

  action_fallback MovieWeb.FallbackController

  def index(conn, params) do
    user_id = params["user_id"]
    favorites = Core.list_favorites(user_id)
    render(conn, :index, favorites: favorites)
  end

  def create(conn, %{"favorite" => favorite_params}) do
    user_id = favorite_params["user_id"]
    content_id = favorite_params["content_id"]

    with {:ok, %User{} = user} <- Core.get_user(user_id),
         {:ok, %Content{} = content} <- Core.get_content(content_id),
         {:ok, %Favorite{} = favorite} <- Core.create_favorite(user, content) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/favorites/#{favorite}")
      |> render(:show, favorite: favorite)
    else
      {:error, :invalid_content} ->
        handle_invalid_input(conn)

      {:error, :invalid_user} ->
        handle_invalid_input(conn)

      error ->
        error
    end
  end

  defp handle_invalid_input(conn) do
    conn
    |> put_status(422)
    |> put_view(MovieWeb.ErrorJSON)
    |> render("422.json")
  end

  def show(conn, %{"id" => id}) do
    favorite = Core.get_favorite!(id)
    render(conn, :show, favorite: favorite)
  end

  def delete(conn, %{"id" => id}) do
    favorite = Core.get_favorite!(id)

    with {:ok, %Favorite{}} <- Core.delete_favorite(favorite) do
      send_resp(conn, :no_content, "")
    end
  end
end
