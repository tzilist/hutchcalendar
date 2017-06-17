defmodule HutchCalendar.Repo.Migrations.CreateReminderType do
  use Ecto.Migration

  def change do
    create table(:reminder_types, primary_key: false) do
      add :type, :string, null: false, primary_key: true
    end

  end
end
