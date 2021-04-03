defmodule Discuss.Users do
  alias Discuss.Repo
  alias Discuss.User
  alias Ecto.Changeset

  def find_by_id(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def find_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def create_or_update(user_params) do
    case find_by_email(user_params.email) do
      {:error, :not_found} -> Repo.insert(User.changeset(%User{}, user_params))
      {:ok, user} -> Changeset.change(user, user_params) |> Repo.update()
    end
  end
end
