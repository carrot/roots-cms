path  = require 'path'
Roots = require 'roots'

client = new Roots(path.join(__dirname, 'client'))
client.compile()

server = require './server'
server.listen(process.env.PORT || 2222)
