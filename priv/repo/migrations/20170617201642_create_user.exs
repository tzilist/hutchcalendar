defmodule HutchCalendar.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string
      add :phone_number_extension, :integer
      add :phone_number, :integer
      timestamps()
    end

  end
end
