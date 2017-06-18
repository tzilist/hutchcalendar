import React from 'react';
import BigCalendar from 'react-big-calendar';
import moment from 'moment';

import "./styles.css";
import "react-big-calendar/lib/css/react-big-calendar.css"

BigCalendar.setLocalizer(
  BigCalendar.momentLocalizer(moment),
);

const Calendar = props => (
  <div className="container">
    <BigCalendar
      selectable
      onSelectSlot={props.addAppointment}
      events={props.events}
      startAccessor='start'
      endAccessor='end'
    />
  </div>
);

export default Calendar
