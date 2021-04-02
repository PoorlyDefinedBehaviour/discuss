defmodule Discuss.Topics.Create do
  alias Discuss.Repo
  alias Discuss.Topic

  def call(title) do
    changeset = Topic.changeset(%Topic{}, %{title: title})
    Repo.insert(changeset)
  end
end
