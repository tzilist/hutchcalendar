import React from 'react';
import BigCalendar from 'react-big-calendar';
import moment from 'moment';

import events from './events';

import "./styles.css";
import "react-big-calendar/lib/css/react-big-calendar.css"

BigCalendar.setLocalizer(
  BigCalendar.momentLocalizer(moment),
);

const Calendar = props => (
  <div className="container">
    <BigCalendar
      events={events}
      startAccessor='start'
      endAccessor='end'
    />
  </div>
);

export default Calendar
