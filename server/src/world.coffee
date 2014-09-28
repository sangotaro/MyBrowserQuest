EventEmitter = require('events').EventEmitter
_ = require 'underscore'

module.exports = class World extends EventEmitter
  constructor: (@id, @maxPlayers, @server) ->
    console.log 'World::constructor'
    @ups = 50
    @map = null
    @playerCount = 0

    @on 'playerConnect', @onPlayerConnect
    @on 'playerEnter', @onPlayerEnter

  run: ->
    console.log 'World::run'

    # TODO: mapの生成

    # main loop
    setInterval =>
      @processGroups()
      @processQueues()
    , 1000 / @ups

  onPlayerConnect: (player) ->
    console.log 'World::onPlayerConnect'
    console.log player.isDead

  onPlayerEnter: (player) ->
    console.log 'World::onPlayerEnter'
    # TODO: playerの各種コールバックを設定
    player.on 'move', ->
      console.log 'move'

  processGroups: ->
#    console.log 'World::progressGroups'

  processQueues: ->
#    console.log 'World::processQueues'

  addPlayer: (player) ->
    console.log 'World::addPlayer'
#    @emit 'playerEnter', player
