defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string, null: false

    belongs_to :user, Discuss.User
    has_many :comments, Discuss.Comment

    timestamps()
  end

  @doc false
  def changeset(struct \\ %__MODULE__{}, attrs \\ %{}) do
    struct
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
