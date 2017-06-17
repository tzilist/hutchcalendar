defmodule HutchCalendar.ReservationController do
  use HutchCalendar.Web, :controller

  alias HutchCalendar.Reservation

  def index(conn, _params) do
    reservations = Repo.all(Reservation)
    render(conn, "index.json", reservations: reservations)
  end

  def create(conn, %{"reservation" => reservation_params}) do
    changeset = Reservation.changeset(%Reservation{}, reservation_params)

    case Repo.insert(changeset) do
      {:ok, reservation} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", reservation_path(conn, :show, reservation))
        |> render("show.json", reservation: reservation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HutchCalendar.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id)
    render(conn, "show.json", reservation: reservation)
  end

  def update(conn, %{"id" => id, "reservation" => reservation_params}) do
    reservation = Repo.get!(Reservation, id)
    changeset = Reservation.changeset(reservation, reservation_params)

    case Repo.update(changeset) do
      {:ok, reservation} ->
        render(conn, "show.json", reservation: reservation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HutchCalendar.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation = Repo.get!(Reservation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reservation)

    send_resp(conn, :no_content, "")
  end
end
