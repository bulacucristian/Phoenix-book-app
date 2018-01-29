defmodule Rumbl.ApiView do
  use Rumbl.Web, :view

  def render("students.json", %{students: students}) do
    render_many(students, Rumbl.ApiView, "student.json", as: :student)
  end

  def render("student.json", %{student: student}) do
    %{
      id: student.id,
      name: student.name,
      surname: student.surname,
      group_id: student.group_id,
      attendecies: student.attendancies
    }
  end

  def render("laboratories.json", %{laboratories: laboratories}) do
    render_many(laboratories, Rumbl.ApiView, "laboratory.json", as: :laboratory)
  end

  def render("updated.json", %{}) do
    %{message: "update success"}
  end

  def render("laboratory.json", %{laboratory: laboratory}) do
    %{
      lab_name: laboratory.lab_name,
      lab_day: laboratory.lab_day,
      lab_hour: laboratory.lab_hour,
      lab_group: laboratory.lab_group
    }
  end

end
