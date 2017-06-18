import React from 'react';
import request from 'superagent';
import Calendar from '../Calendar/Calendar.jsx';
import Header from '../Header/Header.jsx';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: [],
      conferenceRooms: [],
      events: [],
    };
    this.addConferenceRoom = this.addConferenceRoom.bind(this);
    this.addAppointment = this.addAppointment.bind(this);
  }

  componentDidMount() {
    request
      .get('/api/user')
      .end((err, res) => {
        if (err) throw Error(err);
        this.setUsers(res.body.data);
      });

    request
      .get('/api/conference-room')
      .end((err, res) => {
        if (err) throw Error(err);
        this.setConferenceRooms(res.body.data);
      });

    request
      .get('/api/reservations')
      .end((err, res) => {
        if (err) throw Error(err);
        this.setEvents(res.body.data);
      });
  }

  setEvents(initialEvents) {
    const events = initialEvents.map(event => (
      {
        start: new Date(event.time_start),
        end: new Date(event.time_end),
        title: event.title,
      }
    ));

    this.setState({ events });
  }

  setConferenceRooms(conferenceRooms) {
    this.setState({ conferenceRooms });
  }

  setUsers(users) {
    this.setState({ users });
  }

  addConferenceRoom() {
    const name = window.prompt('What should this conference room be called?')
    const body = {
      conference_room: {
        name,
      },
    };
    request
      .post('/api/conference-room')
      .send(body)
      .end((err, res) => {
        if (err) throw Error(err);
        const { conferenceRooms } = this.state;
        this.setState({ conferenceRooms: [...conferenceRooms, res.body.data] });
      });
  }

  addAppointment(slotInfo) {
    const body = {
      reservation: {
        time_start: new Date(slotInfo.start),
        time_end: new Date(slotInfo.end),
        conference_room_id: 1,
        title: 'test appointment',
      },
    };
    request
      .post('/api/reservations')
      .send(body)
      .end((err, res) => {
        if (err) throw Error(err);
        const events = [...this.state.events];
        const {
          title,
          time_end: end,
          time_start: start,
        } = res.body.data;
        events.push({ title, end, start });
        this.setState({ events });
      });
  }

  render() {
    return (
      <div>
        <Header
          users={this.state.users}
          conferenceRooms={this.state.conferenceRooms}
          addConferenceRoom={this.addConferenceRoom}
        />
        <Calendar
          addAppointment={this.addAppointment}
          events={this.state.events}
        />
      </div>
    );
  }
}
