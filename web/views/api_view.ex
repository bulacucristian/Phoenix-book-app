defmodule Rumbl.ApiView do
  use Rumbl.Web, :view

  def render("students.json", %{students: students}) do
    render_many(students, Rumbl.ApiView, "student.json", as: :student)
  end

  def render("student.json", %{student: student}) do
    %{
      name: student.name,
      surname: student.surname,
      username: student.username,
      email: student.email,
      group_id: student.group_id
    }
  end

end
