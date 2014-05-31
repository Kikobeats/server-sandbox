var express = require('express');
var app = express();

var path = "build/website";


app.use("/assets", express.static(__dirname + '/build/website/assets'));
app.use("/gitbook", express.static(__dirname + '/build/website/gitbook'));

app.get('/', function(req, res){
  res.sendfile(__dirname + '/build/website/index.html');
});

var port = process.env.PORT || 3000;

var server = app.listen(port, function() {
    console.log('Listening on port %d', server.address().port);
});
