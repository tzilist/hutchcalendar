# HutchCalendar

To start your Phoenix app:

  * Install Elixir dependencies with `mix deps.get`
  * Install node dependencies with `yarn` or `npm install`
  * Create and edit the file `/config/dev.exs`. See `dev.example.exs` for an example config.
  The big thing to do here really is set up your PSQL uname/pw
  * Create and setup your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


# API Documentation

There are several routes included in this particular project.

## `/api/users`

here are the method/route combinations that will work:

`GET: /api/users` - Delivers a list of all current users

```
POST: /api/users
body: '{
  "name": string // Users name (not optional)
  "phone_extension": integer // phone extension in case of international usage (optional)
  "phone_number": integer //user's phone number(optional)
  "email": string // user's email (optional)
}'
```
Route adds a new user

```
PUT: /api/users/:id
body: '{
  "name": string // Users name (not optional)
  "phone_extension": integer // phone extension in case of international usage (optional)
  "phone_number": integer //user's phone number(optional)
  "email": string // user's email (optional)
}'
```
Updates the user with the matching ID in the route

`Delete: /api/users/:id` - Deletes the user with matching ID

## `/api/conference-room`

here are the method/route combinations that will work:

`GET: /api/conference-room` - Delivers a list of all rooms
```
POST: /api/conference-room
body: '{
  "name": string // Conference room's name (not optional)
}'
```
Route adds a new conference room

```
PUT: /api/conference-room/:id
body: '{
  "name": string//Users name (not optional)
}'
```
Updates the conference room with the matching ID in the route

`Delete: /api/conference-room/:id` - Deletes the conference room with matching ID

## `/api/reservations`

here are the method/route combinations that will work:

`GET: /api/reservations` - Delivers a list of all current meetings

```
POST: /api/reservations
body: '{
  conference_room_id: integer // conference room id to be used
  time_end: ISO8601 DateTime // time meeting will end
  time_start: ISO8601 DateTime // time meeting will start
  title: string // title of meeting
  invitations: [
    user_id: integer // user to be invited
    ... // more user ids
  ]
}'
```
Route adds a new meeting

```
PUT: /api/reservation-users/:id
body: '{
  conference_room_id: integer // conference room id to be used
  time_end: ISO8601 DateTime // time meeting will end
  time_start: ISO8601 DateTime // time meeting will start
  title: string // title of meeting
  invitations: [
    user_id: integer // user to be invited
    ... // more user ids
  ]
}'
```
Updates the meeting with the matching ID in the route

`Delete: /api/users/:id` - Deletes the meeting with matching ID

## `/api/reservation-users`

NOTE: Inplace, currently unused
Intended to deliver a list of all attendees of a meeting

`GET: /api/reservation-users` - Delivers a list of all current meetings

```
POST: /api/reservations-users
body: '{
  user_id: integer // user's id
  reservation_id: integer // meeting reservation id
  reminder: 'email' || 'text' // type of reminder the user wants
  reminder_time: integer // how many minutes the user wants to be alerted before their meeting
}'
```
Route adds a reservation-user, to be used when the accept an invite

```
PUT: /api/reservations-users/:id
body: '{
  user_id: integer // user's id
  reservation_id: integer // meeting reservation id
  reminder: 'email' || 'text' // type of reminder the user wants
  reminder_time: integer // how many minutes the user wants to be alerted before their meeting
}'
```
Updates the reservation-user with the matching ID in the route

`Delete: /api/reservation-user/:id` - Deletes the reservation-user with matching ID

## Currently Working

Although the frontend is a little buggy, the backend is CRUD cappable for everything but reservation-users. The only portion of this challenge left is to add the reminder and ability to accept an invitation.

## Design decisions

Working in Elixir made this challenge fairly easy to build out a really thought out and safe backend. The big design decision came to how to setup the PSQL database.

The current tables are as follows:

```
conference_rooms
_______________
id: pkey
name: string
```

```
users
_____
id: pkey
name: string
email: string
phone_extension: integer
phone_number: integer
```
Note here the phone extension is separate so internationalization of this project would be trivial

```
reservations
____________
id: pkey
conference_room_id: references : conference_rooms
time_start: utc timestamp
time_end: utc timestamp
```

```
invitations
____________
id: pkey
reservation_id: references : reservations
user_id: references : users
```
this table allows us to see which users were invited to which meeting once accepted, they would be put in the next table

```
reservation_users
_________________
id: pkey
user_id: references : user
reservation_id: references : reservations
reminder: references : reminder_type
reminder_time: integer
```
and finally

```
reminder_type
_____________
email
text
```

One thing to note was the ability to check if a meeting creation/move was vaild in that no other meetings were scheduled at that time. This is done via a simple SQL query (via Ecto), which you can see in `/web/services/reservation_service` under `HutchCalendar.ReservationSerivce.query_availability/3`. This does a query to check for serveral edge cases in scheduling, namely that
1. The meeting doesn't fall exacly inside another meeting (or match it exactly too).
2. The end of the new meeting doesn't fall inside the start and end of a currently scheduled meeting
3. The begining of the new meeting doesn't fall inside the start and end of a currently scheduled meeting

## Further Working
Availability for a meeting is checked on the current room requested, so, suggesting other rooms would be fairly trivial. We could begin checking other rooms with the same query, and if any of them return the correct results, we can suggest that room.

Creating a GenStage module to consume new invitations and send them out via an email/text would be fairly straight forward. Based off of the user's settings, we can generate a link, which would bring them to a page with an accept/reject button

Allowing user's to see more details of their meeting (i.e., who is going) would be another task to complete.

Sending out reminders via a GenStage module would also be trivial enough, once connected with an email service or a text based service (i.e. Twillio)

Testing is not completed at all, and probably currently broken. This would be one of the next things done to finish this project up.


## Frontend

Frontend is generated with webpack. There are serveral things of note happening

1. We are doing creating chunks based off of the code. The resulting chunks are:
`bundle.js` (our actual code), `view.js` (react code), and `commons.js` (any other npm modules needed). This is important as it allows users in the future to only download what is needed. If we update our calendar app but not say, the `react` and `react-dom` npm modules, the only thing the user will download is our updated component. This same exact thing is also happening with the CSS.
2. We are also generating our HTML file via webpack as it can safetly put all the required `js` and `css` files in the correct order.

The react frontend is a bit buggy thanks to a buggy calendar react component. Most of the code is from outside react components, however, if you look carefully you can see a few lines of code that interacts with our elixir backend.

Going forward, I would have liked to have added the `jest` framework for testing (as I think snapshot testing is really easy, fast, and most importantly, doesn't require Selenium), although, the new headless chrome with lighthouse might be another option.

I believe that is all for now. Feel free to contact me with any questions or concerns. This project was fairly hefty and I probably spent too much time on the front end to be honest. Going back, I think I would have finished the backend first before trying to make it a fully usable web app.
