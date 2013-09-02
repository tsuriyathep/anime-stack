###
Functions here are for REST, they are formatted non-camel-case to match closely with URI
###

fs = require 'fs'
path = require 'path'

#__________________________________________________________________________________________________#
#DATABASE

#Import data from JSON file to mongo 
exports.db_import = ($req, $res)->
	fs.readFile (path.join __dirname, 'data/products.json'), ($err, $data)->
		if $err then throw $err
		
		#Convert file JSON into object
		rows = JSON.parse $data

		#Store into MongoDB collection
		collection = global.mongo.collection 'products'
		await 
			for row in rows
				collection.save row, defer err

		#Show server
		if err then $res.send 400, err
		else $res.send 200, "Mongo collection [products] added rows from [/server/data/products.json]"


#Empty mongo collection
exports.db_reset = ($req, $res)->
	collection = global.mongo.collection 'products'
	await collection.remove defer err
	if err then $res.send 400, err
	else $res.send 200, "Mongo collection [products] is now empty"


#Show list of products
exports.db_list = ($req, $res)->
	collection = global.mongo.collection 'products'
	await collection.find defer err,rows
	if err then $res.send 400, err
	else $res.send 200, rows
