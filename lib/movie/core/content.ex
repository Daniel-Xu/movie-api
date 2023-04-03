defmodule Movie.Core.Content do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contents" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(content, attrs) do
    content
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
