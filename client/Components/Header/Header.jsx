import React from 'react';


export default class Header extends React.PureComponent {
  render() {
    const { users, conferenceRooms } = this.props;
    const usersList = users.map((user) => (
      <li>
        {user.name}
        {user.email}
      </li>
    ));

    const conferenceList = conferenceRooms.map((room) => (
      <li>
        {room.name}
      </li>
    ));

    return (
      <div>
        <span>Users</span>
        <ul>{usersList}</ul>
        <span>Conference Rooms</span>
        <ul>{conferenceList}</ul>
      </div>
    )
  }
}
