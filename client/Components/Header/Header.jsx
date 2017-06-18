import React from 'react';
import PropTypes from 'prop-types';
import NavBarHeader from '../NavBar/NavBar.jsx';

export default class Header extends React.Component {
  render() {
    console.log(this.props);
    const { users, conferenceRooms } = this.props;
    const usersList = users.map(user => (
      <li key={`${user.id}-user`}>
        {user.name}
        {user.email}
      </li>
    ));

    const conferenceList = conferenceRooms.map(room => (
      <li key={`${room.id}-room`}>
        {room.name}
      </li>
    ));

    return (
      <div>
        <NavBarHeader addConferenceRoom={this.props.addConferenceRoom} />
        <span>Users</span>
        <ul>{usersList}</ul>
        <span>Conference Rooms</span>
        <ul>{conferenceList}</ul>
      </div>
    );
  }
}

Header.propTypes = {
  users: PropTypes.arrayOf(
    PropTypes.shape({
      name: PropTypes.string,
      id: PropTypes.number,
    }),
  ),
  conferenceRooms: PropTypes.arrayOf(
    PropTypes.shape({
      name: PropTypes.string,
      id: PropTypes.number,
    }),
  ),
};
