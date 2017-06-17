defmodule HutchCalendar.ReservationControllerTest do
  use HutchCalendar.ConnCase

  alias HutchCalendar.Reservation
  @valid_attrs %{time_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, time_start: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, reservation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = get conn, reservation_path(conn, :show, reservation)
    assert json_response(conn, 200)["data"] == %{"id" => reservation.id,
      "conference_room_id" => reservation.conference_room_id,
      "time_start" => reservation.time_start,
      "time_end" => reservation.time_end}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, reservation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, reservation_path(conn, :create), reservation: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Reservation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, reservation_path(conn, :create), reservation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = put conn, reservation_path(conn, :update, reservation), reservation: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Reservation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = put conn, reservation_path(conn, :update, reservation), reservation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    reservation = Repo.insert! %Reservation{}
    conn = delete conn, reservation_path(conn, :delete, reservation)
    assert response(conn, 204)
    refute Repo.get(Reservation, reservation.id)
  end
end
