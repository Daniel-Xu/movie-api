defmodule Movie.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movie.Core` context.
  """

  @doc """
  Generate a unique user name.
  """
  def unique_user_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: unique_user_name()
      })
      |> Movie.Core.create_user()

    user
  end
end
