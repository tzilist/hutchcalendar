defmodule HutchCalendar.InvitationView do
  use HutchCalendar.Web, :view

  def render("index.json", %{invitations: invitations}) do
    %{data: render_many(invitations, HutchCalendar.InvitationView, "invitation.json")}
  end

  def render("show.json", %{invitation: invitation}) do
    %{data: render_one(invitation, HutchCalendar.InvitationView, "invitation.json")}
  end

  def render("invitation.json", %{invitation: invitation}) do
    %{id: invitation.id,
      user_id: invitation.user_id,
      reservation_id: invitation.reservation_id}
  end
end
