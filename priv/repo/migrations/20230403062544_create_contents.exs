defmodule Movie.Repo.Migrations.CreateContents do
  use Ecto.Migration

  def change do
    create table(:contents) do
      add :name, :string

      timestamps()
    end

    create unique_index(:contents, [:name])
  end
end
