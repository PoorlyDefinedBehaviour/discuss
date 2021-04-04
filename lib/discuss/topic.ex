defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string, null: false

    belongs_to :user, Discuss.User

    timestamps()
  end

  @doc false
  def changeset(struct \\ %__MODULE__{}, attrs \\ %{}) do
    struct
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
