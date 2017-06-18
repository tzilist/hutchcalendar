defmodule HutchCalendar.Reservation do
  use HutchCalendar.Web, :model

  alias HutchCalendar.Repo

  schema "reservations" do
    field :time_start, :utc_datetime
    field :time_end, :utc_datetime
    field :title, :string
    field :conference_room_id, :integer
    has_many :invitations, HutchCalendar.Invitation

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    IO.inspect params, label: "params"
    struct
    |> Repo.preload(:invitations)
    |> cast(params, [:time_start, :time_end, :conference_room_id, :title])
    |> cast_assoc(:invitations)
    |> validate_required([:time_start, :time_end, :title])
    |> foreign_key_constraint(:conference_room_id)
  end
end
