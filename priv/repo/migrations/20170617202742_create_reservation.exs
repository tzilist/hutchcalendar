defmodule HutchCalendar.Repo.Migrations.CreateReservation do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :time_start, :utc_datetime, null: false
      add :time_end, :utc_datetime, null: false
      add :conference_room_id, references(:conference_rooms, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:reservations, [:conference_room_id])

  end
end
