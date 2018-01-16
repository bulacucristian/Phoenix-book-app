defmodule Rumbl.User do
  use Rumbl.Web, :model

  schema "users" do
    field :username, :string
    field :name, :string
    field :surname, :string
    field :password, :string, virtual: true
    field :email, :string
    field :group_id, :string
    field :password_hash, :string

    timestamps
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username], [])
    |> validate_length(:username, min: 1, max: 20)
    #|> validate_length(:surname, min: 1, max: 20)
    #|> validate_format(:email, ~r/@/)
    #|> validate_format(:group_id, min: 5, max: 7)
    |> unique_constraint(:email)
  end

  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
        _ ->
        changeset
    end
  end
end
