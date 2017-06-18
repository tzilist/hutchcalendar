import React from 'react';
import request from 'superagent';
import Calendar from '../Calendar/Calendar.jsx';
import Header from '../Header/Header.jsx';
import NewConferenceRoomModal from '../Modals/NewConferenceRoomModal.jsx';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: [],
      conferenceRooms: [],
      events: [],
      showNewConferenceRoomModal: false,
    };
    this.addConferenceRoom = this.addConferenceRoom.bind(this);
    this.addAppointment = this.addAppointment.bind(this);
    this.showConferenceRoomModal = this.showConferenceRoomModal.bind(this);
    this.hideConferenceRoomModal = this.hideConferenceRoomModal.bind(this);
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
        id: event.id
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

  showConferenceRoomModal() {
    this.setState({ showNewConferenceRoomModal: true });
  }

  hideConferenceRoomModal() {
    this.setState({ showNewConferenceRoomModal: false });
  }

  addConferenceRoom(name) {
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

  addAppointment(start, end, title, roomId) {
    const body = {
      reservation: {
        time_start: start,
        time_end: end,
        conference_room_id: roomId,
        title,
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
          id,
        } = res.body.data;
        events.push({ id, title, end: new Date(end), start: new Date(start) });
        this.setState({ events });
      });
  }

  render() {
    return (
      <div>
        <Header
          users={this.state.users}
          conferenceRooms={this.state.conferenceRooms}
          showConferenceRoomModal={this.showConferenceRoomModal}
        />
        <Calendar
          addAppointment={this.addAppointment}
          events={this.state.events}
          rooms={[...this.state.conferenceRooms]}
        />
        <NewConferenceRoomModal
          show={this.state.showNewConferenceRoomModal}
          hide={this.hideConferenceRoomModal}
          addConferenceRoom={this.addConferenceRoom}
        />
      </div>
    );
  }
}
