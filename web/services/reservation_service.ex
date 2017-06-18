defmodule HutchCalendar.ReservationService do
  import Ecto.Query

  alias HutchCalendar.Repo

  def query_availability(time_start, time_end, room_id) do
    {:ok, time_start} = NaiveDateTime.from_iso8601(time_start)
    {:ok, time_start} = Ecto.DateTime.cast(time_start)
    {:ok, time_end} = NaiveDateTime.from_iso8601(time_end)
    {:ok, time_end} = Ecto.DateTime.cast(time_end)
    query = from res in "reservations",
      where: res.conference_room_id == ^room_id and res.time_start < type(^time_end, Ecto.DateTime),
      or_where: res.id == ^room_id and res.time_end < type(^time_start, Ecto.DateTime),
      or_where: res.id == ^room_id and res.time_start <= type(^time_start, Ecto.DateTime) and res.time_end >= type(^time_end, Ecto.DateTime),
      select: res.id

    Repo.all(query)
    |> IO.inspect
  end
end
