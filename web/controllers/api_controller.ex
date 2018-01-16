defmodule Rumbl.ApiController do
  use Rumbl.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  action_fallback Rumbl.FallbackController
  alias Rumbl.{Repo, User}

  def verify_credentials(conn, username, given_pass) do
   user = Repo.get_by(User, %{username: username})

   cond do
     user && checkpw(given_pass, user.password_hash) ->
       {:ok, user, conn}
     user ->
       {:error, :unauthorized, conn}
     true ->
       dummy_checkpw()
       {:error, :invalid_client, conn}
   end
 end


  def authenticate(conn, params) do
    IO.inspect("atundasjnsdjksfd")
    case verify_credentials(conn, params["username"], params["password"]) do
      {:ok, %User{} = user, conn} ->
        conn |> json(%{access_token: Rumbl.TokenService.generate_token(user)})
      {:error, _message, conn} ->
        conn
          |> put_status(400)
          |> json(%{error: :invalid_grant})
    end
  end

  def get_users(conn, _params) do
    IO.inspect("get_users")
    students = Repo.all(User)
    render(conn, "students.json", students: students)

  end
end
