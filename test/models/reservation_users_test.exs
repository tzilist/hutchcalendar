defmodule HutchCalendar.ReservationUsersTest do
  use HutchCalendar.ModelCase

  alias HutchCalendar.ReservationUsers

  @valid_attrs %{reminder_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ReservationUsers.changeset(%ReservationUsers{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ReservationUsers.changeset(%ReservationUsers{}, @invalid_attrs)
    refute changeset.valid?
  end
end
