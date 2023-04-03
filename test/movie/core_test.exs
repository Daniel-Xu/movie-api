defmodule Movie.CoreTest do
  use Movie.DataCase

  alias Movie.Core

  describe "users" do
    alias Movie.Core.User

    import Movie.CoreFixtures

    @invalid_attrs %{name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Core.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Core.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %User{} = user} = Core.create_user(valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %User{} = user} = Core.update_user(user, update_attrs)
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_user(user, @invalid_attrs)
      assert user == Core.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Core.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Core.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Core.change_user(user)
    end
  end

  describe "contents" do
    alias Movie.Core.Content

    import Movie.CoreFixtures

    @invalid_attrs %{name: nil}

    test "list_contents/0 returns all contents" do
      content = content_fixture()
      assert Core.list_contents() == [content]
    end

    test "get_content!/1 returns the content with given id" do
      content = content_fixture()
      assert Core.get_content!(content.id) == content
    end

    test "create_content/1 with valid data creates a content" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Content{} = content} = Core.create_content(valid_attrs)
      assert content.name == "some name"
    end

    test "create_content/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_content(@invalid_attrs)
    end

    test "update_content/2 with valid data updates the content" do
      content = content_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Content{} = content} = Core.update_content(content, update_attrs)
      assert content.name == "some updated name"
    end

    test "update_content/2 with invalid data returns error changeset" do
      content = content_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_content(content, @invalid_attrs)
      assert content == Core.get_content!(content.id)
    end

    test "delete_content/1 deletes the content" do
      content = content_fixture()
      assert {:ok, %Content{}} = Core.delete_content(content)
      assert_raise Ecto.NoResultsError, fn -> Core.get_content!(content.id) end
    end

    test "change_content/1 returns a content changeset" do
      content = content_fixture()
      assert %Ecto.Changeset{} = Core.change_content(content)
    end
  end

  describe "favorites" do
    alias Movie.Core.Favorite

    import Movie.CoreFixtures

    test "list_favorites/1 returns all favorites for specific user" do
      favorite = favorite_fixture() |> Repo.preload(:content)
      assert Core.list_favorites(favorite.user_id) == [favorite]
    end

    test "get_favorite!/1 returns the favorite with given id" do
      favorite = favorite_fixture()
      assert Core.get_favorite!(favorite.id) == favorite
    end

    test "delete_favorite/1 deletes the favorite" do
      favorite = favorite_fixture()
      assert {:ok, %Favorite{}} = Core.delete_favorite(favorite)
      assert_raise Ecto.NoResultsError, fn -> Core.get_favorite!(favorite.id) end
    end
  end
end
