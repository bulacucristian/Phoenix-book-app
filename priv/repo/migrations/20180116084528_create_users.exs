defmodule Rumbl.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :surname, :string
      add :username, :string
      add :password_hash, :string
      add :email, :string
      add :group_id, :string
      add :attendancies, :map

      timestamps
    end
    create unique_index(:users, [:email, :username])
  end
end
