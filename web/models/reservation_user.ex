defmodule HutchCalendar.ReservationUser do
  use HutchCalendar.Web, :model

  schema "reservation_users" do
    field :reminder_time, Ecto.DateTime
    belongs_to :user, HutchCalendar.User
    belongs_to :reservation, HutchCalendar.Reservation
    belongs_to :reminder, HutchCalendar.Reminder

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:reminder_time])
    |> validate_required([:reminder_time])
  end
end
