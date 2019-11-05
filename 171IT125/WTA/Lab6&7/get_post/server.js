var http = require('http');
var fs = require('fs');

var server = http.createServer(function (req, res) {

    if (req.method === "GET") {
        res.writeHead(200, { "Content-Type": "text/html" });
        fs.createReadStream("index.html", "UTF-8").pipe(res);
    } else if (req.method === "POST") {

        var body = "";
        req.on("data", function (chunk) {
            body += chunk + "<br>";
        });

        req.on("end", function () {
            res.writeHead(200, { "Content-Type": "text/html" });
            res.end(body);
        });
    }

}).listen(3000);
console.log("Listening at port 3000");