defmodule Rumbl.Repo.Migrations.CreateLaboratories do
  use Ecto.Migration

  def change do
    create table(:laboratories) do
      add :lab_name, :string
      add :lab_day, :string
      add :lab_hour, :string
      add :lab_group, :string

      timestamps
    end

  end
end
