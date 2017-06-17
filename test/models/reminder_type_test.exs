defmodule HutchCalendar.ReminderTypeTest do
  use HutchCalendar.ModelCase

  alias HutchCalendar.ReminderType

  @valid_attrs %{type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ReminderType.changeset(%ReminderType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ReminderType.changeset(%ReminderType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
