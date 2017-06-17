defmodule HutchCalendar.ReservationUserView do
  use HutchCalendar.Web, :view

  def render("index.json", %{reservation_users: reservation_users}) do
    %{data: render_many(reservation_users, HutchCalendar.ReservationUserView, "reservation_users.json")}
  end

  def render("show.json", %{reservation_users: reservation_users}) do
    %{data: render_one(reservation_users, HutchCalendar.ReservationUserView, "reservation_users.json")}
  end

  def render("reservation_users.json", %{reservation_users: reservation_users}) do
    %{id: reservation_users.id,
      user_id: reservation_users.user_id,
      reservation_id: reservation_users.reservation_id,
      reminder: reservation_users.reminder,
      reminder_time: reservation_users.reminder_time}
  end
end
