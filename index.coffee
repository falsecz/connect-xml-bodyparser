xml2js = require 'xml2js'

module.exports = () ->

	(req, res, next) ->
		return next() unless "application/xml" is req.headers['content-type']

		buf = ""
		req.setEncoding "utf8"
		req.on "data", (chunk) ->
			buf += chunk

		req.on "end", ->
			parser = new xml2js.Parser()
			parser.parseString buf, (err, json) ->
				if err
					err.status = 400
					return next err
				req.body = json
				req.rawBody = buf
				next()
