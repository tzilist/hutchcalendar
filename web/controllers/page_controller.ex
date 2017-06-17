defmodule HutchCalendar.PageController do
  use HutchCalendar.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
