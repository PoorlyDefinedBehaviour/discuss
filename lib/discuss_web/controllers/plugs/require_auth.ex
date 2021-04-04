defmodule DiscussWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias DiscussWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    case conn.assigns[:user] do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in")
        |> redirect(to: Helpers.topic_path(conn, :index))
        |> halt()

      _user ->
        conn
    end
  end
end
