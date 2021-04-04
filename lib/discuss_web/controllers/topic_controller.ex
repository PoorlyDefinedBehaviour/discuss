defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topic
  alias Discuss.Topics

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    topics = Topics.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{user: user}} = conn, %{"topic" => topic}) do
    case Topics.create(user, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"topic_id" => topic_id}) do
    case Topics.find_by_id(topic_id) do
      {:error, :not_found} ->
        conn
        |> put_flash(:error, "Topic not found")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:ok, topic} ->
        render(conn, "edit.html", changeset: Topic.changeset(topic), topic: topic)
    end
  end

  def update(%{assigns: %{user: user}} = conn, %{"topic_id" => topic_id, "topic" => topic}) do
    case Topics.update_by_id(user, topic_id, topic) do
      {:error, :not_found} ->
        conn
        |> put_flash(:error, "Topic not found")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, :not_topic_owner} ->
        conn
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, topic, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: topic)

      {:ok, _updated_topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  def delete(%{assigns: %{user: user}} = conn, %{"topic_id" => topic_id}) do
    case Topics.delete_by_id(user, topic_id) do
      {:error, :not_topic_owner} ->
        conn |> redirect(to: Routes.topic_path(conn, :index))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "It was not possible to delete topic")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic deleted")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end
end
