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
end
