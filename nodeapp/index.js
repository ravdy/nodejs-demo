var express = require('express');
var app = express();

app.get('/', function (req, res) {
    res.send('{ "response": "Hello, Welcome to Vdfsdfsdfsdfalaxy" }');
});

app.get('/will', function (req, res) {
    res.send('{ "response": "Hello Wofdsfsdfsdfrld" }');
});
app.get('/ready', function (req, res) {
    res.send('{ "response": " Great!, It " }');
});
app.listen(process.env.PORT || 3000);
module.exports = app;
