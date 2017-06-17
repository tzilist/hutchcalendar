defmodule HutchCalendar.Reservation do
  use HutchCalendar.Web, :model

  schema "reservations" do
    field :time_start, Ecto.DateTime
    field :time_end, Ecto.DateTime
    belongs_to :conference_room, HutchCalendar.ConferenceRoom

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time_start, :time_end])
    |> validate_required([:time_start, :time_end])
  end
end
