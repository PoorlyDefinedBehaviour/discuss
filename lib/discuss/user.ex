defmodule Discuss.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email]}

  schema "users" do
    field :email, :string, null: false
    field :provider, :string, null: false
    field :token, :string, null: false

    has_many :topics, Discuss.Topic
    has_many :comments, Discuss.Comment

    timestamps()
  end

  @doc false
  def changeset(user \\ %__MODULE__{}, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
