defmodule HutchCalendar.ConferenceRoomController do
  use HutchCalendar.Web, :controller

  alias HutchCalendar.ConferenceRoom

  def index(conn, _params) do
    conference_rooms = Repo.all(ConferenceRoom)
    render(conn, "index.json", conference_rooms: conference_rooms)
  end

  def create(conn, %{"conference_room" => conference_room_params}) do
    changeset = ConferenceRoom.changeset(%ConferenceRoom{}, conference_room_params)

    case Repo.insert(changeset) do
      {:ok, conference_room} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", conference_room_path(conn, :show, conference_room))
        |> render("show.json", conference_room: conference_room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HutchCalendar.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    conference_room = Repo.get!(ConferenceRoom, id)
    render(conn, "show.json", conference_room: conference_room)
  end

  def update(conn, %{"id" => id, "conference_room" => conference_room_params}) do
    conference_room = Repo.get!(ConferenceRoom, id)
    changeset = ConferenceRoom.changeset(conference_room, conference_room_params)

    case Repo.update(changeset) do
      {:ok, conference_room} ->
        render(conn, "show.json", conference_room: conference_room)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HutchCalendar.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    conference_room = Repo.get!(ConferenceRoom, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(conference_room)

    send_resp(conn, :no_content, "")
  end
end
