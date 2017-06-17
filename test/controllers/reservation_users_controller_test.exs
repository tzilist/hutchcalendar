defmodule HutchCalendar.ReservationUsersControllerTest do
  use HutchCalendar.ConnCase

  alias HutchCalendar.ReservationUsers
  @valid_attrs %{reminder_time: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, reservation_users_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    reservation_users = Repo.insert! %ReservationUsers{}
    conn = get conn, reservation_users_path(conn, :show, reservation_users)
    assert json_response(conn, 200)["data"] == %{"id" => reservation_users.id,
      "user_id" => reservation_users.user_id,
      "reservation_id" => reservation_users.reservation_id,
      "reminder" => reservation_users.reminder,
      "reminder_time" => reservation_users.reminder_time}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, reservation_users_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, reservation_users_path(conn, :create), reservation_users: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ReservationUsers, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, reservation_users_path(conn, :create), reservation_users: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    reservation_users = Repo.insert! %ReservationUsers{}
    conn = put conn, reservation_users_path(conn, :update, reservation_users), reservation_users: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ReservationUsers, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reservation_users = Repo.insert! %ReservationUsers{}
    conn = put conn, reservation_users_path(conn, :update, reservation_users), reservation_users: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    reservation_users = Repo.insert! %ReservationUsers{}
    conn = delete conn, reservation_users_path(conn, :delete, reservation_users)
    assert response(conn, 204)
    refute Repo.get(ReservationUsers, reservation_users.id)
  end
end
