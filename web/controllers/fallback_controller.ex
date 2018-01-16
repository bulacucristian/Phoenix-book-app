defmodule Rumbl.FallbackController do
  use Rumbl.Web, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Rumbl.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, _entity, %Ecto.Changeset{} = changeset, %{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Rumbl.ChangesetView, "error.json", changeset: changeset)
  end

  # def call(conn, {:error, :not_found}) do
  #   conn
  #   |> put_status(:not_found)
  #   |> render(Rumbl.ErrorView, :"404")
  # end
end
