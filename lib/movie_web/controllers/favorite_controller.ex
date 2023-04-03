defmodule MovieWeb.FavoriteController do
  use MovieWeb, :controller

  alias Movie.Core
  alias Movie.Core.Favorite

  action_fallback MovieWeb.FallbackController

  def index(conn, _params) do
    favorites = Core.list_favorites()
    render(conn, :index, favorites: favorites)
  end

  def create(conn, %{"favorite" => favorite_params}) do
    with {:ok, %Favorite{} = favorite} <- Core.create_favorite(favorite_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/favorites/#{favorite}")
      |> render(:show, favorite: favorite)
    end
  end

  def show(conn, %{"id" => id}) do
    favorite = Core.get_favorite!(id)
    render(conn, :show, favorite: favorite)
  end

  def update(conn, %{"id" => id, "favorite" => favorite_params}) do
    favorite = Core.get_favorite!(id)

    with {:ok, %Favorite{} = favorite} <- Core.update_favorite(favorite, favorite_params) do
      render(conn, :show, favorite: favorite)
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Core.get_favorite!(id)

    with {:ok, %Favorite{}} <- Core.delete_favorite(favorite) do
      send_resp(conn, :no_content, "")
    end
  end
end
