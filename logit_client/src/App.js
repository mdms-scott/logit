import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Requests from "./requests";

class App extends Component {
  render() {
    return (
      <div className="App">
        <section className="section">
          <Requests />
        </section>
      </div>
    );
  }
}

export default App;
