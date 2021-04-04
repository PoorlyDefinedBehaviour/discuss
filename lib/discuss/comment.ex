defmodule Discuss.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :content, :string, null: false

    belongs_to :user, Discuss.User
    belongs_to :topic, Discuss.Topic

    timestamps()
  end

  @doc false
  def changeset(comment \\ %__MODULE__{}, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content, :user_id, :topic_id])
    |> validate_required([:content, :user_id, :topic_id])
  end
end
