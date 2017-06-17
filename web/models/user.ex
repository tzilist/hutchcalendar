defmodule HutchCalendar.User do
  use HutchCalendar.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :phone_number_extension, :integer
    field :phone_number, :integer
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :phone_number_extension, :phone_number])
    |> validate_required([:name])
  end
end
