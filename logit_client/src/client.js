/* eslint-disable no-undef */
function loadRequests(index, q, warning=false, slow=false) {
  var url = `requests`
  if (index) {
    url = `requests?page=${index}`
  }
  if (q) {
    url += `&q=${q}`
  }
  if (warning) {
    url+= `&warnings=true`
  }
  if (slow) {
    url+= `&slowest=true`
  }

  return fetch(url, {
    accept: "application/json",
  })
    .then(checkStatus)
    .then(parseJSON)
    .catch(err => {
      console.log(err.response);
      throw err;
    })
}

function checkStatus(response) {
  if (response.status >= 200 && response.status < 300) {
    return response;
  }
  const error = new Error(`HTTP Error ${response.statusText}`);
  error.status = response.statusText;
  error.response = response;
  console.log(error); // eslint-disable-line no-console
  throw error;
}

function parseJSON(response) {
  // console.log(response.json());
  return response.json();
}

const Client = { loadRequests };
export default Client;
