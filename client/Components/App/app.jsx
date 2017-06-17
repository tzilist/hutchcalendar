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
    };
    this.setUsers = this.setUsers.bind(this);
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
  }

  setConferenceRooms(conferenceRooms) {
    this.setState({ conferenceRooms });
  }

  setUsers(users) {
    this.setState({ users });
  }

  render() {
    return (
      <div>
        <Header
          users={this.state.users}
          conferenceRooms={this.state.conferenceRooms}
          />
        <Calendar />
      </div>
    );
  }
}
