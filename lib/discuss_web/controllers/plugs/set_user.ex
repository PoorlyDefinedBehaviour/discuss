defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  alias Discuss.Accounts

  def init(_params) do
  end

  def call(conn, _params) do
    case get_session(conn, :user_id) do
      nil ->
        assign(conn, :user, nil)

      user_id ->
        case Accounts.get_user(user_id) do
          {:error, :not_found} -> assign(conn, :user, nil)
          {:ok, user} -> assign(conn, :user, user)
        end
    end
  end
end
