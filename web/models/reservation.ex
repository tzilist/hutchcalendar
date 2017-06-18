defmodule HutchCalendar.Reservation do
  use HutchCalendar.Web, :model

  schema "reservations" do
    field :time_start, :utc_datetime
    field :time_end, :utc_datetime
    field :title, :string
    field :conference_room_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:time_start, :time_end, :conference_room_id, :title])
    |> validate_required([:time_start, :time_end, :title])
    |> foreign_key_constraint(:conference_room_id)
  end
end
