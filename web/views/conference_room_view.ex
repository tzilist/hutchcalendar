defmodule HutchCalendar.ConferenceRoomView do
  use HutchCalendar.Web, :view

  def render("index.json", %{conference_rooms: conference_rooms}) do
    %{data: render_many(conference_rooms, HutchCalendar.ConferenceRoomView, "conference_room.json")}
  end

  def render("show.json", %{conference_room: conference_room}) do
    %{data: render_one(conference_room, HutchCalendar.ConferenceRoomView, "conference_room.json")}
  end

  def render("conference_room.json", %{conference_room: conference_room}) do
    %{id: conference_room.id,
      name: conference_room.name}
  end
end
