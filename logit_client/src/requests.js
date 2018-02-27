import React from "react";
import Client from "./client"

class RequestsControl extends React.Component {
  state = {
    collectedRequests: [],
    selectedRequest: {},
    currentPage: 1
  };

  constructor(props) {
    super(props);
    Client.loadRequests(1, null).then(response => {
      this.setState({
        collectedRequests: response,
        selectedRequest: response[0],
        currentPage: 1
      });
    }).catch(err => {
      console.log(err)
    })
  }

  handleRequestClick = (e, idx) => {
    this.setState({
      selectedRequest: e
    });
  }

  handleNextPageClick = () => {
    Client.loadRequests(this.state.currentPage + 1).then(response => {
      this.setState({
        collectedRequests: response,
        selectedRequest: response[0],
        currentPage: this.state.currentPage + 1
      });
    }).catch(err => {
      console.log(err)
    })
  }

  handlePreviousPageClick = () => {
    Client.loadRequests(this.state.currentPage - 1).then(response => {
      this.setState({
        collectedRequests: response,
        selectedRequest: response[0],
        currentPage: this.state.currentPage - 1
      });
    }).catch(err => {
      console.log(err)
    })
  }

  handleSearch = (e) => {
    Client.loadRequests(1, e.target.value).then(response => {
      this.setState({
        collectedRequests: response,
        selectedRequest: response[0],
        currentPage: 1
      });
    }).catch(err => {
      console.log(err)
    })
  }

  handleWarningClick = () => {
    Client.loadRequests(this.state.currentPage, null, true).then(response => {
      this.setState({
        collectedRequests: response,
        selectedRequest: response[0],
        currentPage: this.state.currentPage
      });
    }).catch(err => {
      console.log(err)
    })
  }

  handleSlowClick = () => {
    Client.loadRequests(this.state.currentPage, null, false, true).then(response => {
      this.setState({
        collectedRequests: response,
        selectedRequest: response[0],
        currentPage: this.state.currentPage
      });
    }).catch(err => {
      console.log(err)
    })
  }

  renderRequest = (request, idx) => {
    return (
      <div className="box is-paddingless request-list-item" key={idx} onClick={(e) => this.handleRequestClick(request, idx)}>
        {request.uuid}
        <br />
        {request.uri}
      </div>
    )
  }

  renderRequestInfo = (request) => {
    if(request) {
      return (
        <div className="box has-text-left">
          <div className="container">UUID: {request.uuid}</div>
          <br />
          <div className="container">Request Info</div>
          <div className="container">URI: {request.uri}</div>
          <div className="container">Requester: {request.requester}</div>
          <div className="container">TimeStamp: {request.timestamp}</div>
          <div className="container">Request Type: {request.request_type}</div>
          <div className="container">Controller: {request.controller}</div>
          <div className="container">Action: {request.action}</div>
          <div className="container">Parameters: {JSON.stringify(request.parameters)}</div>
          <div className="container">ContentType: {request.content_type}</div>
          <br />
          <div className="container">Response Info</div>
          <div className="container">Response Code:{request.response}</div>
          {request.view_time != null && <div className="container">Views: {request.view_time}ms</div>}
          {request.ar_time != null && <div className="container">Active Record:{request.ar_time}ms</div>}
          {request.total_time != null && <div className="container">Total Time: {request.total_time}ms</div>}
          <div className="container">Render: {request.render}</div>
          {request.render_time != null && <div className="container">Time to Render: {request.render_time}ms</div>}
          <br />
          <div className="container">Full Body: {request.full_body}</div>
        </div>
      )
    }
  }

  render () {
    return (
      <div>
        <div className="level">
          <div className="level-item">
            <div className="button" onClick={(e) => this.handleWarningClick()}>Warnings</div>
          </div>
          <div className="level-item">
            <div className="button" onClick={(e) => this.handleSlowClick()}>Slowest Requests</div>
          </div>
        </div>
        <div className="field">
          <div className="control">
            <input className="input" type="text" placeholder="Search" value={this.state.value} onChange={this.handleSearch} />
          </div>
        </div>
        <div className="columns">
          <div className="column">
            {this.state.collectedRequests.map((request, idx) => this.renderRequest(request, idx))}
          </div>
          <div className="column">
            {this.renderRequestInfo(this.state.selectedRequest)}
          </div>
        </div>
        <nav className="pagination" role="navigation" aria-label="pagination">
          <a className="pagination-previous" onClick={(e) => this.handlePreviousPageClick()}>Previous</a>
          <a className="pagination-next" onClick={(e) => this.handleNextPageClick()}>Next page</a>
        </nav>
      </div>
    )
  }
}

export default RequestsControl
