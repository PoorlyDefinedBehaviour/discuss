defmodule Discuss.Discussions.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content, :user]}

  schema "comments" do
    field :content, :string, null: false

    belongs_to :user, Discuss.Accounts.User
    belongs_to :topic, Discuss.Discussions.Topic

    timestamps()
  end

  @doc false
  def changeset(comment \\ %__MODULE__{}, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content, :user_id, :topic_id])
    |> validate_required([:content, :user_id, :topic_id])
  end
end
