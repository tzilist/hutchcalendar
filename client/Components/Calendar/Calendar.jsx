import React from 'react';
import BigCalendar from 'react-big-calendar';
import moment from 'moment';

import EditReservationModal from '../Modals/EditReservationModal.jsx';

import "./styles.css";
import "react-big-calendar/lib/css/react-big-calendar.css"

BigCalendar.setLocalizer(
  BigCalendar.momentLocalizer(moment),
);

class Calendar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      showEditReservationModal: false,
      info: null,
    };
    this.showEditReservationModal = this.showEditReservationModal.bind(this);
    this.hideEditReservationModal = this.hideEditReservationModal.bind(this);
  }

  showEditReservationModal(input) {
    this.setState({
      showEditReservationModal: true,
      info: input,
    });
  }

  hideEditReservationModal() {
    this.setState({
      showEditReservationModal: false,
      info: null,
    });
  }


  render() {
    return (
      <div className="container">
        <BigCalendar
          selectable
          onSelectSlot={this.showEditReservationModal}
          onSelectEvent={event => console.log(event)}
          events={this.props.events}
        />
        <EditReservationModal
          show={this.state.showEditReservationModal}
          hide={this.hideEditReservationModal}
          info={{...this.state.info}}
          addAppointment={this.props.addAppointment}
          rooms={this.props.rooms}
        />
      </div>
    );
  }
}

export default Calendar
