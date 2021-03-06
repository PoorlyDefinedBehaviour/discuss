defmodule Discuss.Discussions.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string, null: false

    belongs_to :user, Discuss.Accounts.User
    has_many :comments, Discuss.Discussions.Comment

    timestamps()
  end

  @doc false
  def changeset(struct \\ %__MODULE__{}, attrs \\ %{}) do
    struct
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
