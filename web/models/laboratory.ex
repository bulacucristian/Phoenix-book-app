defmodule Rumbl.Laboratory do
  use Rumbl.Web, :model

  schema "laboratories" do
    field :lab_name, :string
    field :lab_day, :string
    field :lab_hour, :string
    field :lab_group, :string

    timestamps
  end

  def changeset(laboratories, attrs) do
    laboratories
    |> cast(attrs,[:lab_name, :lab_day, :lab_hour, :lab_group], [])
    |> validate_length(:lab_name, min: 1, max: 30)
    |> validate_length(:lab_day, min: 3, max: 7)
    |> validate_length(:lab_hour, min: 4, max: 4)
    |> validate_length(:lab_group, min: 5, max: 6)
    |> unique_constraint(:lab_name)
  end

end
