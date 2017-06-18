# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HutchCalendar.Repo.insert!(%HutchCalendar.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

reminder_types = ["email", "text"]

Enum.each(reminder_types, fn x ->
  HutchCalendar.Repo.get_by(HutchCalendar.ReminderType, type: x)
  |> case do
    nil -> HutchCalendar.Repo.insert!(%HutchCalendar.ReminderType{type: x})
    _ -> nil
  end
end)

conference_rooms = ["Init Room"]

Enum.each(conference_rooms, fn x ->
  HutchCalendar.Repo.get_by(HutchCalendar.ConferenceRoom, name: x)
  |> case do
    nil -> HutchCalendar.Repo.insert!(%HutchCalendar.ConferenceRoom{name: x})
    _ -> nil
  end
end)


users = [%{name: "Ted",
           email: "tzilist@gmail.com"},
         %{name: "Victor",
           email: "victor@hutch.com"}]

Enum.each(users, fn x ->
  HutchCalendar.Repo.get_by(HutchCalendar.User, name: x.name)
  |> case do
    nil ->
      changeset = HutchCalendar.User.changeset(%HutchCalendar.User{}, x)
      HutchCalendar.Repo.insert!(changeset)
    _ -> nil
  end
end)
