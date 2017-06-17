defmodule HutchCalendar.Invitation do
  use HutchCalendar.Web, :model

  schema "invitations" do
    belongs_to :user, HutchCalendar.User
    belongs_to :reservation, HutchCalendar.Reservation

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
