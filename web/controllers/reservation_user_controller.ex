defmodule HutchCalendar.ReservationUserController do
  use HutchCalendar.Web, :controller

  alias HutchCalendar.ReservationUser

  def index(conn, _params) do
    reservation_users = Repo.all(ReservationUser)
    render(conn, "index.json", reservation_users: reservation_users)
  end

  def create(conn, %{"reservation_users" => reservation_users_params}) do
    changeset = ReservationUser.changeset(%ReservationUser{}, reservation_users_params)

    case Repo.insert(changeset) do
      {:ok, reservation_users} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", reservation_user_path(conn, :show, reservation_users))
        |> render("show.json", reservation_users: reservation_users)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HutchCalendar.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reservation_users = Repo.get!(ReservationUser, id)
    render(conn, "show.json", reservation_users: reservation_users)
  end

  def update(conn, %{"id" => id, "reservation_users" => reservation_users_params}) do
    reservation_users = Repo.get!(ReservationUser, id)
    changeset = ReservationUser.changeset(reservation_users, reservation_users_params)

    case Repo.update(changeset) do
      {:ok, reservation_users} ->
        render(conn, "show.json", reservation_users: reservation_users)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HutchCalendar.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reservation_users = Repo.get!(ReservationUser, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reservation_users)

    send_resp(conn, :no_content, "")
  end
end
