defmodule Rumbl.LaboratoryController do
  use Rumbl.Web, :controller
  alias Rumbl.Laboratory

  def show(conn, %{"id" => id}) do
    laboratory = Repo.get(Laboratory, id)
    |> IO.inspect()
    render conn, "show.html", laboratory: laboratory
  end

  def new(conn ,_params) do
    changeset = Laboratory.changeset(%Laboratory{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def index(conn, _params) do
    laboratories = Repo.all(Rumbl.Laboratory)
    |> IO.inspect()
    render conn, "index.html", laboratories: laboratories
  end

  def create(conn, %{"laboratory" => laboratory_params}) do
    changeset = Laboratory.changeset(%Laboratory{}, laboratory_params)
    |> IO.inspect()
    case Repo.insert(changeset) |> IO.inspect() do
      {:ok, laboratory} ->
        conn
        # |> Rumbl.Auth.login()
        # |> put_flash(:info, "#{user.name} created!")
        |>redirect(to: laboratory_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
