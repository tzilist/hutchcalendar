import React from 'react';
import {
  Modal,
  FormGroup,
  FormControl,
  Button
} from 'react-bootstrap';


class NewConferenceRoomModal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      input: '',
    };

    this.handleChange = this.handleChange.bind(this);
    this.createNewConference = this.createNewConference.bind(this);
  }

  handleChange(e) {
    this.setState({ input: e.target.value });
  }

  createNewConference() {
    this.props.addConferenceRoom(this.state.input);
    this.props.hide();
    this.setState({ input: '' });
  }

  render() {
    return (
      <Modal show={this.props.show} onHide={this.props.hide}>
        <Modal.Header closeButton>
          <Modal.Title>Create Conference Room</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <form>
            <FormGroup bsSize="large">
              <FormControl
                type="text"
                value={this.state.input}
                placeholder="Enter conference room name here..."
                onChange={this.handleChange}
              />
            </FormGroup>
          </form>
        </Modal.Body>
        <Modal.Footer>
          <Button onClick={this.props.hide}>Close</Button>
          <Button bsStyle="primary" onClick={this.createNewConference}>Create</Button>
        </Modal.Footer>
      </Modal>
    );
  }
}


export default NewConferenceRoomModal;
