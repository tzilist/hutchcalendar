defmodule HutchCalendar.InvitationControllerTest do
  use HutchCalendar.ConnCase

  alias HutchCalendar.Invitation
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, invitation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = get conn, invitation_path(conn, :show, invitation)
    assert json_response(conn, 200)["data"] == %{"id" => invitation.id,
      "user_id" => invitation.user_id,
      "reservation_id" => invitation.reservation_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, invitation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, invitation_path(conn, :create), invitation: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Invitation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, invitation_path(conn, :create), invitation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = put conn, invitation_path(conn, :update, invitation), invitation: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Invitation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = put conn, invitation_path(conn, :update, invitation), invitation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = delete conn, invitation_path(conn, :delete, invitation)
    assert response(conn, 204)
    refute Repo.get(Invitation, invitation.id)
  end
end
