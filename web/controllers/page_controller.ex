defmodule HutchCalendar.PageController do
  use HutchCalendar.Web, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/html", "utf-8")
    |> send_file(200, "priv/static/index.html")
  end
end
