defmodule MovieWeb.ContentJSON do
  alias Movie.Core.Content

  @doc """
  Renders a list of contents.
  """
  def index(%{contents: contents}) do
    %{data: for(content <- contents, do: data(content))}
  end

  @doc """
  Renders a single content.
  """
  def show(%{content: content}) do
    %{data: data(content)}
  end

  defp data(%Content{} = content) do
    %{
      id: content.id,
      name: content.name
    }
  end
end
