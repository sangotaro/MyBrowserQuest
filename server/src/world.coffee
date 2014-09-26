_ = require 'underscore'

module.exports = class World
  constructor: (@id, @maxPlayers, @server) ->
    console.log 'World::constructor'
#    console.log @id
#    console.log @maxPlayers
#    console.log @server
    @ups = 50
    @map = null
    @playerCount = 0


  run: ->
    console.log 'World::run'

  onPlayerConnect: (player) ->
    console.log 'World::onPlayerConnect'
    # TODO: playerのpositionを取得するコールバックを設定



  onPlayerEnter: (player) ->
    console.log 'World::onPlayerEnter'
