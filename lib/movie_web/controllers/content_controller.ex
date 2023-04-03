defmodule MovieWeb.ContentController do
  use MovieWeb, :controller

  alias Movie.Core
  alias Movie.Core.Content

  action_fallback MovieWeb.FallbackController

  def index(conn, _params) do
    contents = Core.list_contents()
    render(conn, :index, contents: contents)
  end

  def create(conn, %{"content" => content_params}) do
    with {:ok, %Content{} = content} <- Core.create_content(content_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/contents/#{content}")
      |> render(:show, content: content)
    end
  end

  def show(conn, %{"id" => id}) do
    content = Core.get_content!(id)
    render(conn, :show, content: content)
  end

  def update(conn, %{"id" => id, "content" => content_params}) do
    content = Core.get_content!(id)

    with {:ok, %Content{} = content} <- Core.update_content(content, content_params) do
      render(conn, :show, content: content)
    end
  end

  def delete(conn, %{"id" => id}) do
    content = Core.get_content!(id)

    with {:ok, %Content{}} <- Core.delete_content(content) do
      send_resp(conn, :no_content, "")
    end
  end
end
