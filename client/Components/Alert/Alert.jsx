import React from 'react';
import Alert from 'react-s-alert';

import 'react-s-alert/dist/s-alert-default.css';
import 'react-s-alert/dist/s-alert-css-effects/jelly.css';

const alertOpts = {
  position: 'top-right',
  effect: 'jelly',
  offset: 20,
  timeout: 3000,
};

export default class AnimatedAlert extends React.PureComponent {

  componentDidUpdate() {
    const { alerts } = this.props;
    Alert.error(alerts[0], alertOpts);
  }

  render() {
    return <Alert stack />;
  }
}
