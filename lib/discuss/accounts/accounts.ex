defmodule Discuss.Accounts do
  alias Discuss.Repo
  alias Discuss.Accounts.User
  alias Ecto.Changeset

  def get_user(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def get_user_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def create_or_update_user(user_params) do
    case get_user_by_email(user_params.email) do
      {:error, :not_found} -> Repo.insert(User.changeset(%User{}, user_params))
      {:ok, user} -> Changeset.change(user, user_params) |> Repo.update()
    end
  end
end
