defmodule HutchCalendar.Repo.Migrations.CreateReservationUsers do
  use Ecto.Migration

  def change do
    create table(:reservation_users) do
      add :reminder_time, :utc_datetime, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :reservation_id, references(:reservations, on_delete: :delete_all), null: false
      add :reminder, references(:reminder_types, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:reservation_users, [:user_id])
    create index(:reservation_users, [:reservation_id])
    create index(:reservation_users, [:reminder])

  end
end
