defmodule Discuss.Topics do
  alias Discuss.Repo
  alias Discuss.Topic

  def list_topics() do
    Repo.all(Topic)
  end

  def create(user, topic) do
    changeset = Topic.changeset(%Topic{}, Map.merge(topic, %{"user_id" => user.id}))

    Repo.insert(changeset)
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
end
