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
  HutchCalendar.Repo.insert!(%HutchCalendar.ReminderType{type: x})
end)
