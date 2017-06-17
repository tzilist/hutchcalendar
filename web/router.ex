defmodule HutchCalendar.Router do
  use HutchCalendar.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HutchCalendar do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end


  scope "/api", HutchCalendar do
    pipe_through :api

    resources "/conference-room", ConferenceRoomController
    resources "/reservations", ReservationController
    resources "/user", UserController
    resources "/invitation", InvitationController
    resources "/reservation-users", ReservationUserController
  end
end
