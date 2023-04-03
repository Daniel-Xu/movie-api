defmodule Movie.Core.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do
    belongs_to :user, Movie.Core.User
    belongs_to :content, Movie.Core.Content

    timestamps()
  end

  def changeset_with_assoc(user, content) do
    favorite = Ecto.build_assoc(user, :favorites)

    Ecto.build_assoc(content, :favorites, favorite)
    |> change()
  end
end
