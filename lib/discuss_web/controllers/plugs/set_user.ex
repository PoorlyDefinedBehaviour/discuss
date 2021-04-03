defmodule DiscussWeb.Plugs.SetUser do
  alias Plug.Conn
  alias Discuss.Users

  def init(_params) do
  end

  def call(conn, _params) do
    case Conn.get_session(conn, :user_id) do
      nil ->
        Conn.assign(conn, :user, nil)

      user_id ->
        case Users.find_by_id(user_id) do
          {:error, :not_found} -> Conn.assign(conn, :user, nil)
          {:ok, user} -> Conn.assign(conn, :user, user)
        end
    end
  end
end
