import React from 'react';
import {
  Navbar,
  Nav,
  NavDropdown,
  MenuItem,
} from 'react-bootstrap';

import './styles.css';

const NavBarHeader = (props) => (
  <Navbar>
    <Navbar.Brand>Hutch Calendar</Navbar.Brand>
    <Nav>
      <NavDropdown eventKey={3} title="Conference Rooms" id="basic-nav-dropdown">
        <MenuItem
          eventKey={3.1}
          onClick={props.addConferenceRoom}
        >
          Add Room
        </MenuItem>
      </NavDropdown>
    </Nav>
  </Navbar>
);

export default NavBarHeader;
