import React from 'react';
import {
  Modal,
  Button,
  FormGroup,
  FormControl,
  ControlLabel,
} from 'react-bootstrap';

import DateTime from 'react-datetime';

import './styles.css';

class EditReservationModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      start: null,
      end: null,
    };

    this.handleTitleChange = this.handleTitleChange.bind(this);
    this.handleStartChange = this.handleStartChange.bind(this);
    this.handleEndChange = this.handleEndChange.bind(this);
    this.handleCreateAppointment = this.handleCreateAppointment.bind(this);
  }

  componentWillReceiveProps(nextProps) {
    const { start, end } = nextProps.info;
    this.setState({
      start,
      end,
    });
  }

  handleTitleChange(e) {
    this.setState({ title: e.target.value });
  }

  handleStartChange(e) {
    this.setState({ start: e.toDate() });
  }

  handleEndChange(e) {
    this.setState({ end: e.toDate() });
  }

  handleCreateAppointment() {
    const { start, end, title } = this.state;
    this.props.addAppointment(start, end, title, this.room.value)
    this.props.hide();
  }

  render() {
    if (!this.props.show) return null;
    const rooms = this.props.rooms.map(rm => (
      <option value={rm.id} key={`${rm.name}-${rm.id}`}>{rm.name}</option>
    ));
    return (
      <Modal show={this.props.show} onHide={this.props.hide}>
        <Modal.Header closeButton>
          <Modal.Title>Edit Appointment</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <h2>Event Title</h2>
          <form>
            <FormGroup bsSize="large">
              <FormControl
                type="text"
                value={this.state.title}
                placeholder="Title"
                onChange={this.handleTitleChange}
              />
            </FormGroup>
          </form>
          <h2>Start Time</h2>
          <DateTime
            onChange={this.handleStartChange}
            value={this.state.start}
          />
          <h2>End Time</h2>
          <DateTime
            value={this.state.end}
            onChange={this.handleEndChange}
          />
          <FormGroup controlId="formControlsSelect">
            <ControlLabel>Select</ControlLabel>
            <FormControl
              componentClass="select"
              placeholder="select"
              inputRef={ref => { this.room = ref; }}
            >
              {rooms}
            </FormControl>
          </FormGroup>
        </Modal.Body>
        <Modal.Footer>
          <Button onClick={this.props.hide}>Close</Button>
          <Button onClick={this.handleCreateAppointment}>Create</Button>
        </Modal.Footer>
      </Modal>
    );
  }
}


export default EditReservationModal;
