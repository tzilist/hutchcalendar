defmodule HutchCalendar.Invitation do
  use HutchCalendar.Web, :model

  schema "invitations" do
    field :user_id, :integer
    field :reservation_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :reservation_id])
    |> validate_required([:user_id, :reservation_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:reservation_id)
  end
end
