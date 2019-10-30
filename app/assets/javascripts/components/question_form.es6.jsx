let initialState = {
  id: Number,
  question: "",
  show_in_list: false,
  selected: "",
  choices: [],
  editMode: false,
}

class QuestionForm extends React.Component {
  constructor(props){
    super(props)
    this.state={
      id: Number,
      question: "",
      show_in_list: false,
      types: [],
      selected: "",
      choices: [],
      editMode: false,
      auth_token: ""
    }
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e){
    if(this.state.selected === ""){
      e.preventDefault()
      alert("Please set an Answer Type for the question.");
    }
    else if(this.state.selected === "choice" && this.state.choices.length === 0){
      e.preventDefault()
      alert("Please add choices for the question.");
    }else{
      if(this.state.selected === "choice")
        this.state.choices.forEach((val)=>{
          $('<input>').attr({
            type: 'hidden',
            name: 'choices[]',
            value: val
          }).appendTo('form');
        })
        
      if(this.state.editMode)
        $('<input>').attr({
          type: 'hidden',
          name: 'id',
          value: this.state.id
        }).appendTo('form');
    }
  }

  clear(){
    this.setState(initialState);
  }

  componentWillMount(){
    this.setState({types: this.props.types, auth_token: this.props.auth_token})
    if(this.props.question){
      this.setState({
        id: this.props.question.id,
        question: this.props.question.question,
        show_in_list: this.props.question.show_in_list,
        selected: this.props.question.answer_type,
        choices: this.props.question.choices,
        editMode: true
      },()=>{
        $('.selectpicker').selectpicker('val', this.state.selected);
      })
    }
  }
  
  render () {
    return (
      <React.Fragment>
        <form className="needs-validation" action='/questions' method='post' onSubmit={(e)=>{this.handleSubmit(e)}} >
          {
            this.state.editMode ? 
            <input type="hidden" value="put" name="method"/>:
            <input type="hidden" value="post" name="method"/>
          }
          <div className="modal-body">
            <div className="form-group">
              <label htmlFor="question">Question</label>
              <input name="question" id="question" type="text" aria-describedby="questionHelp" className="form-control" value={this.state.question} onChange={(e)=>{this.setState({question: e.target.value})}} maxLength={155} pattern="([^\s]+([' ']{1})?)+" required/>
              <small id="questionHelp" className="form-text text-muted">Please enter a question with no consecutive white spaces.</small>
            </div>

            <div className="form-check">
              <label className="form-check-label" htmlFor="show-in-list">Show in list?</label>
              <input name="show_in_list" type="checkbox" className="form-check-input" id="show-in-list" checked={this.state.show_in_list} value={this.state.show_in_list} onChange={(e)=>{this.setState({show_in_list: e.target.checked})}}/>
            </div>

            <div className="form-group">
              <label htmlFor="answer-type">Answer Type</label>
              <select name="answer_type" className="selectpicker form-control" title="Choose..." id="answer-type" onChange={(e)=>{ this.setState({selected: e.target.value}) }}>
                {
                  Object.entries(this.state.types).map((val)=>{
                    return(
                      this.state.selected === val[0] ?
                      <option key={val[1]} selected>{val[0]}</option>:
                      <option key={val[1]}>{val[0]}</option>
                    )
                  })
                }
              </select>
              {
                this.state.selected === "choice" ?
                <ChoiceComponent state={this.state}/>
                
                :
                null
              }
            </div>
          </div> 
          
          <input type="hidden" value={this.state.auth_token} name="authenticity_token"/>

          <div className="modal-footer">
            <div className="actions">
              <button type="button" className="btn btn-secondary" data-dismiss="modal" onClick={()=>{this.clear()}}>Close</button>
              &nbsp;&nbsp;
              <button type="submit" className="btn btn-primary">Submit</button>
            </div>
          </div> 
        </form>
      </React.Fragment>
    );
  }
}


