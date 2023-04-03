defmodule Movie.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :content_id, references(:contents, on_delete: :delete_all)

      timestamps()
    end

    create index(:favorites, [:user_id])
    create index(:favorites, [:content_id])
    create unique_index(:favorites, [:user_id, :content_id])
  end
end
