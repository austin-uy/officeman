let time = new Date().toLocaleString();

class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      time: new Date().toLocaleString()
    };
  }

  tick() {
    this.setState({
      time: new Date().toLocaleString()
    });
  }

  componentDidMount() {
    this.intervalID = setInterval(
      () => this.tick(),
      1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.intervalID);
  }

  render () {
    return (
      <React.Fragment>
        {this.state.time}
      </React.Fragment>
    );
  }
}


