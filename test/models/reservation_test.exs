defmodule HutchCalendar.ReservationTest do
  use HutchCalendar.ModelCase

  alias HutchCalendar.Reservation

  @valid_attrs %{time_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, time_start: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reservation.changeset(%Reservation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reservation.changeset(%Reservation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
