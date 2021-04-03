defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.Users

  plug Ueberauth

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    conn.assigns.ueberauth_auth

    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}

    case Users.create_or_update(user_params) do
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end
end
