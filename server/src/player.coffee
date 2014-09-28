EventEmitter = require('events').EventEmitter
_ = require 'underscore'

module.exports = class Player extends EventEmitter
  constructor: (@socket, @world) ->
    console.log 'Player::constructor'
    @hasEnteredGame = false;
    @isDead = false;
    @lastCheckpoint = null

    # クライアントに接続完了を通知
    @socket.emit 'connection', hello: 'world'

    # hello
    @socket.on 'hello', (data) =>
      console.log data

      # 自身をworldに加える
      @world.addPlayer @
      @world.emit 'playerEnter', @

    # move
    @socket.on 'move', (data) ->
      console.log data