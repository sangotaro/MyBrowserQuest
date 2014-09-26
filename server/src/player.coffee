_ = require 'underscore'

module.exports = class Player
  constructor: (@socket, @world) ->
    console.log 'Player::constructor'
    @lastCheckpoint = null
    @socket.emit 'news', hello: 'world'
    @socket.on 'my other event', (data) ->
      console.log data