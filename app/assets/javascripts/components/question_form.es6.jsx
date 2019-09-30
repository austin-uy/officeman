let initialState = {
  id: Number,
  question: "",
  show_in_list: false,
  types: [],
  selected: "",
  choices: [],
  editMode: false,
  auth_token: ""
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
      $.ajax({
        url: this.state.editMode ? '/questions/'+this.state.id : '/questions',
        dataType: 'json',
        type: this.state.editMode ? 'PATCH' :'POST',
        data: {
          question: this.state.question, 
          show_in_list: this.state.show_in_list,
          answer_type: this.state.selected,
          choices: this.state.choices,
          authenticity_token: this.state.auth_token
        },
        success: function(data) {
          console.log("Success")
          //redirect with url params on json, return with notice param
        }.bind(this),
        error: function(xhr, status, err) {
         console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
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
      })
    }
  }
  
  render () {
    return (
      <React.Fragment>
        <form className="needs-validation" onSubmit={(e)=>{this.handleSubmit(e)}}>
          <div className="modal-body">
            <div className="form-group">
              <label htmlFor="question">Question</label>
              <input id="question" type="text" className="form-control" value={this.state.question} onChange={(e)=>{this.setState({question: e.target.value})}} required/>
            </div>

            <div className="form-group" id="checkbox-group">
              <input type="checkbox" className="form-check-input" id="show-in-list" checked={this.state.show_in_list} onChange={(e)=>{this.setState({show_in_list: e.target.checked})}}/>
              <label className="form-check-label" htmlFor="show-in-list">Show in list?</label>
            </div>

            <div className="form-group">
              <label htmlFor="answer-type">Answer Type</label>
              <select className="form-control" id="answer-type" onChange={(e)=>{ this.setState({selected: e.target.value}) }}>
                {
                this.state.selected === "" ?
                <option selected> Choose... </option> :
                null
                }
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
                <ChoiceComponent state={this.state}/> :
                null
              }
            </div>
          </div> 



          <div className="modal-footer">
            <div className="actions">
                {
                  this.state.editMode ?
                  <button type="button" className="btn btn-secondary" onClick={()=>{ history.back()}}>Back</button>
                  :
                  <button type="button" className="btn btn-secondary" data-dismiss="modal" onClick={()=>{this.clear()}}>Close</button>
                }
                <button type="submit" className="btn btn-primary">Submit</button>
            </div>
          </div> 
        </form>
      </React.Fragment>
    );
  }
}


