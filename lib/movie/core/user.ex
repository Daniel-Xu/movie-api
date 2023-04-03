defmodule Movie.Core.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string

    has_many :favorites, Movie.Core.Favorite

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
