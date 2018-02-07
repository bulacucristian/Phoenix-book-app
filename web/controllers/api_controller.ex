defmodule Rumbl.ApiController do
  use Rumbl.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  action_fallback Rumbl.FallbackController
  alias Rumbl.{Repo, User, Laboratory}
  require Logger

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
    case verify_credentials(conn, params["username"], params["password"]) do
      {:ok, %User{} = user, conn} ->
        conn |> json(%{access_token: Rumbl.TokenService.generate_token(user)})
      {:error, _message, conn} ->
        conn
          |> put_status(400)
          |> json(%{error: :invalid_grant})
    end
  end

  def register(conn, params) do
    Logger.info("#=> Params received from React: #{inspect params}")
    user_changeset = User.registration_changeset(%User{}, params)

    with {:ok, %User{} = user} <- Repo.insert(user_changeset) do
      Logger.info("#=> Added user : #{inspect user}")
      render(conn, "updated.json", %{})
    end
  end

  def get_users(conn, _params) do
    students = User |> order_by(asc: :id) |> Repo.all()
    # students = Repo.all(User)
    render(conn, "students.json", students: students)
  end

  def get_laboratories(conn, _params) do
    laboratories = Repo.all(Laboratory)
    render(conn, "laboratories.json", laboratories: laboratories)
  end

  def update_attendancies(conn, %{"id" => id} = params)  do
    Logger.info("#=> Params received from React: #{inspect params}")
    user = Repo.get(User, id)
    attendancies = Map.merge(user.attendancies, params["attendancies"])
    user_changeset = User.changeset(user, %{attendancies: attendancies})

    with {:ok, %User{} = user} <- Repo.update(user_changeset) do
      Logger.info("#=> Updated user : #{inspect user}")
      render(conn, "updated.json", %{})
    end
  end
end
