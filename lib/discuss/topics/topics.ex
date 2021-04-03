defmodule Discuss.Topics do
  alias Discuss.Repo
  alias Discuss.Topic

  def list_topics() do
    Repo.all(Topic)
  end

  def create(topic) do
    changeset = Topic.changeset(topic)
    Repo.insert(changeset)
  end

  def find_by_id(topic_id) do
    case Repo.get(Topic, topic_id) do
      nil -> {:error, :not_found}
      topic -> {:ok, topic}
    end
  end

  def update_by_id(topic_id, new_topic_data) do
    with {:ok, topic} <- find_by_id(topic_id) do
      case Repo.update(Topic.changeset(topic, new_topic_data)) do
        {:error, changeset} -> {:error, topic, changeset}
        {:ok, updated_topic} -> {:ok, updated_topic}
      end
    end
  end

  def delete_by_id(topic_id) do
    with {:ok, topic} <- find_by_id(topic_id) do
      Repo.delete(topic)
    end
  end
end
