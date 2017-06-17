defmodule HutchCalendar.Repo.Migrations.CreateInvitation do
  use Ecto.Migration

  def change do
    create table(:invitations) do
      add :user_id, references(:users, on_delete: :nothing)
      add :reservation_id, references(:reservations, on_delete: :nothing)

      timestamps()
    end
    create index(:invitations, [:user_id])
    create index(:invitations, [:reservation_id])

  end
end
