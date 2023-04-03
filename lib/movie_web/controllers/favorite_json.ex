defmodule MovieWeb.FavoriteJSON do
  alias Movie.Core.Favorite

  @doc """
  Renders a list of favorites.
  """
  def index(%{favorites: favorites}) do
    %{data: for(favorite <- favorites, do: data(favorite))}
  end

  @doc """
  Renders a single favorite.
  """
  def show(%{favorite: favorite}) do
    %{data: data(favorite)}
  end

  defp data(%Favorite{} = favorite) do
    %{
      id: favorite.id
    }
  end
end
