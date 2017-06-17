defmodule HutchCalendar.ConferenceRoomControllerTest do
  use HutchCalendar.ConnCase

  alias HutchCalendar.ConferenceRoom
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, conference_room_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    conference_room = Repo.insert! %ConferenceRoom{}
    conn = get conn, conference_room_path(conn, :show, conference_room)
    assert json_response(conn, 200)["data"] == %{"id" => conference_room.id,
      "name" => conference_room.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, conference_room_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, conference_room_path(conn, :create), conference_room: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ConferenceRoom, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, conference_room_path(conn, :create), conference_room: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    conference_room = Repo.insert! %ConferenceRoom{}
    conn = put conn, conference_room_path(conn, :update, conference_room), conference_room: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ConferenceRoom, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    conference_room = Repo.insert! %ConferenceRoom{}
    conn = put conn, conference_room_path(conn, :update, conference_room), conference_room: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    conference_room = Repo.insert! %ConferenceRoom{}
    conn = delete conn, conference_room_path(conn, :delete, conference_room)
    assert response(conn, 204)
    refute Repo.get(ConferenceRoom, conference_room.id)
  end
end
