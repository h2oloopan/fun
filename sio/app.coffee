http = require 'http'
url = require 'url'
io = require 'socket.io'
fs = require 'fs'
path = require 'path'
page = path.resolve 'page.html'
sio = path.resolve 'js/socket.io.js'

server = http.createServer (req, res) ->

	pathname = url.parse(req.url).pathname
	console.log pathname

	switch pathname
		when '/socket.io.js'
			js = fs.readFileSync sio
			res.writeHead 200,
				'Content-Type': 'text/javascript'
			res.end js
		else
			html = fs.readFileSync page
			res.writeHead 200, 
				'Content-Type': 'text/html'
			res.end html

server.listen 8888
io = io server
io.on 'connection', (socket) ->
	socket.emit 'message', 
		message: 'hello world'
