defmodule Discuss.Topics do
  alias Discuss.{Repo, Topic, Comment}
  import Ecto.Query

  def list_topics() do
    Repo.all(Topic)
  end

  def create(user, topic) do
    Topic.changeset(%Topic{}, Map.merge(topic, %{"user_id" => user.id}))
    |> Repo.insert()
  end

  def find_by_id(topic_id) do
    case Repo.get(Topic, topic_id) do
      nil -> {:error, :not_found}
      topic -> {:ok, topic}
    end
  end

  def update_by_id(user, topic_id, new_topic_data) do
    with {:ok, topic} <- find_by_id(topic_id) do
      case topic.user_id do
        user_id when user_id === user.id ->
          case Repo.update(Topic.changeset(topic, new_topic_data)) do
            {:error, changeset} -> {:error, topic, changeset}
            {:ok, updated_topic} -> {:ok, updated_topic}
          end

        _other_user_id ->
          {:error, :not_topic_owner}
      end
    end
  end

  def delete_by_id(user, topic_id) do
    with {:ok, topic} <- find_by_id(topic_id) do
      case topic.user_id do
        user_id when user_id === user.id ->
          Repo.delete(topic)

        _other_user_id ->
          {:error, :not_topic_owner}
      end
    end
  end

  def create_comment(comment) do
    Comment.changeset(%Comment{}, comment)
    |> Repo.insert()
  end

  def find_topic_with_comments_by_id(topic_id) do
    query =
      from topic in Topic,
        where: topic.id == ^topic_id,
        preload: [comments: :user]

    case Repo.one(query) do
      nil -> {:error, :not_found}
      topic -> {:ok, topic}
    end
  end
end
