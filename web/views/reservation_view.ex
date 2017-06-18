defmodule HutchCalendar.ReservationView do
  use HutchCalendar.Web, :view

  def render("index.json", %{reservations: reservations}) do
    %{data: render_many(reservations, HutchCalendar.ReservationView, "reservation.json")}
  end

  def render("show.json", %{reservation: reservation}) do
    %{data: render_one(reservation, HutchCalendar.ReservationView, "reservation.json")}
  end

  def render("reservation.json", %{reservation: reservation}) do
    %{id: reservation.id,
      conference_room_id: reservation.conference_room_id,
      time_start: reservation.time_start,
      time_end: reservation.time_end,
      title: reservation.title}
  end
end
