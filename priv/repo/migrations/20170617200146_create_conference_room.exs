defmodule HutchCalendar.Repo.Migrations.CreateConferenceRoom do
  use Ecto.Migration

  def change do
    create table(:conference_rooms) do
      add :name, :string

      timestamps()
    end

  end
end
