class ChoiceComponent extends React.Component {
  constructor(props){
    super(props)
    this.state={
      choice: ""
    }
  }
  
  addChoice(){
    if(this.state.choice === ""){
      alert("Please fill in a choice.");
    }else{  
      this.props.state.choices.push(this.state.choice)
      this.setState({choice: ""})
    }
  }

  handleEdit(index){
    console.log(index)
    let a = this.props.state.choices.splice(index,1);
    this.setState({choice: a[0]})
  }

  handleDelete(index){
    this.props.state.choices.splice(index,1);
    this.setState({})
  }

  render () {
    return (
      <React.Fragment>
        <div className="form-group">
          <label htmlFor="choice">Choices</label>
          <ul className="list-group">
          {
            this.props.state.choices.map((val,index)=>{
              return(
                <li className="list-group-item" key={index}>
                  <div className="d-flex justify-content-between">
                    <p>{val}</p>
                    <div className="btn-group" role="group" aria-label="Basic example">
                      <button className="btn btn-outline-primary" type="button" onClick={()=>{this.handleEdit(index)}}>Edit</button>
                      <button className="btn btn-outline-danger" type="button" onClick={()=>{this.handleDelete(index)}}>Remove</button>
                    </div>
                  </div>
                </li>
              )
            })
          }
          </ul>
          <div className="input-group">
            <input type="text" className="form-control" id="choice" value={this.state.choice} onChange={(e)=>{this.setState({choice: e.target.value})}} maxLength={40}/>
            <div className="input-group-append">
              <button className="btn btn-outline-secondary" type="button" onClick={()=>{this.addChoice()}}>Add</button>
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}


