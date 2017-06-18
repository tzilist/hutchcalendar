defmodule HutchCalendar.ReservationService do
  import Ecto.Query

  alias HutchCalendar.Repo

  def query_availability(time_start, time_end, room_id) do
    query = from res in "reservations",
      where: res.conference_room_id == ^room_id and res.time_start < type(^time_end, :utc_datetime) and res.time_end > type(^time_end, :utc_datetime),
      or_where: res.conference_room_id == ^room_id and res.time_end > type(^time_start, :utc_datetime) and res.time_start <= type(^time_start, :utc_datetime),
      or_where: res.conference_room_id == ^room_id and res.time_start <= type(^time_start, :utc_datetime) and res.time_end >= type(^time_end, :utc_datetime),
      select: res.id

    Repo.all(query)
  end

end
