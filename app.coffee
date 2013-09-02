#Includes
http = require 'http'
path = require 'path'
express = require 'express'
server = require './server/server'

#Configure express
app = express()
app.configure ->
	app.set 'port', (process.env.PORT or 3000)
	app.use express.favicon (path.join __dirname, 'client/img/favicon.gif')
	app.use express.logger 'dev'
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.cookieParser 'anime'
	app.use express.session 
		secret: 'anime'
		store: new express.session.MemoryStore
	app.use app.router
	app.use express.static (path.join __dirname, 'client') , {maxAge:0}

#Configure express for development
app.configure 'development', ->
	app.use express.errorHandler()

#Fix headers for REST
app.all '*', ($req, $res, $next) ->
	$res.header 'Access-Control-Allow-Origin', '*'
	$res.header 'Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS'
	$res.header 'Access-Control-Allow-Headers', 'Content-Type'
	$res.header 'Cache-Control', 'no-cache, private, no-store, must-revalidate, max-stale=0, post-check=0, pre-check=0'
	$next()

#Create a global mongo variable, will use HEROKU URIs or your own localhost
global.mongo = (require 'mongojs').connect (process.env.MONGOLAB_URI or process.env.MONGOHQ_URI or 'localhost/anime')

#Rest API formatted similar to the URI
app.get '/db/import', server.db_import
app.get '/db/reset', server.db_reset
app.get '/db/list', server.db_list

#Listen
(http.createServer app).listen (app.get 'port'), ->
	console.log 'Application running.'
