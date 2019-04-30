const fs = require('fs');
const url = require('url');
const http = require('http');

const hostname = '0.0.0.0';
const port = 3000;
const counterFile = './data/stateful-hello.txt';

const readCounter = (path) => {
  try {
    return Number(fs.readFileSync(path).toString()) || 0;
  } catch (err) {
    return 0
  }
}

const writeCounter = (path, counter) => {
  fs.writeFile(path, counter, function(err) {
    if (err) {
      return console.log(err);
    }
  });
}

const server = http.createServer((req, res) => {
  console.log('Request URL: ' + req.url)

  var parsed = url.parse(req.url, true);
  var query = parsed.query;
  // if 'msg' is in query, then return that, otherwise ...
  var message = (query && query.msg) ? query.msg : 'Hello World';
  var counter = readCounter(counterFile) + 1;
  writeCounter(counterFile, counter)

  var response = {
    'message': message,
    'counter': counter
  };

  res.statusCode = 200;
  res.setHeader('Content-Type', 'application/json');
  res.end(JSON.stringify(response) + '\n');

  console.log('Response: "' + response.message + '" - counter: ' + response.counter )
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
