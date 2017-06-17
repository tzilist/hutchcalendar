defmodule HutchCalendar.ReminderType do
  use HutchCalendar.Web, :model

  @primary_key false

  schema "reminder_types" do
    field :type, :string, primary_key: true
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type])
    |> validate_required([:type])
    |> unique_constraint(:type, name: "reminder_types_pkey")
  end
end
