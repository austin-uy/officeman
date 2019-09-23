class AnswerType extends React.Component {
  constructor(props){
    super(props)
    this.state={
      question: "",
      show_in_list: false,
      types: [],
    }
  }

  componentWillMount(){
    this.setState({types: this.props.types},()=>{
    })
  }
  
  render () {
    return (
      <React.Fragment>
        <form className="needs-validation">
          <div className="modal-body">
            <div className="form-group">
              <label htmlFor="question">Email address</label>
              <input id="question" type="email" className="form-control" value={this.state.question} onChange={(e)=>{this.setState({question: e.target.value})}} required/>
            </div>

            <div className="form-check">
              <input type="checkbox" className="form-check-input" id="show-in-list" value={this.state.show_in_list} onChange={(e)=>{this.setState({show_in_list: e.target.checked})}}/>
              <label className="form-check-label" htmlFor="show-in-list">Show in list?</label>
            </div>

            <div className="form-group">
              <label htmlFor="answer-type">Answer Type</label>
              <select className="form-control" id="answer-type">
                <option selected> Choose... </option>
                {
                  Object.entries(this.state.types).map((val)=>{
                    return(
                      <option id={val[1]}>{val[0]}</option>
                    )
                  })
                }
              </select>
            </div>

          </div> 



          <div className="modal-footer">
            <div className="actions">
                <button type="button" className="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" className="btn btn-primary">Submit</button>
            </div>
          </div> 
        </form>
      </React.Fragment>
    );
  }
}


