var express = require('express');
var app = express();

app.use("/assets", express.static(__dirname + '/assets'));
app.use("/img", express.static(__dirname + '/img'));

app.get('/', function(req, res){
  res.sendfile(__dirname + '/index.html');
});

var port = process.env.PORT || 3000;

var server = app.listen(port, function() {
    console.log('Listening on port %d', server.address().port);
});
