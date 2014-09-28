fs = require 'fs'
_ = require 'underscore'
express = require 'express'
socketio = require 'socket.io'
World = require './world'
Player = require './player'

# エントリーポイント
main = () ->
  app = express()

  app.get '/', (req, res) ->
    res.send('Hello, World!');

  app.use express.static __dirname + '/../../public'

  server = app.listen 3000
  io = socketio server

  console.log 'Starting BrowserQuest game server...'

  worlds = []

  # WebSocket接続確立コールバック
  io.on 'connection', (socket) ->
    # 空きがあるworldを見つける
    world = _.find worlds, (world) ->
      world.playerCount < 20

    # プレイヤー接続完了
    world?.emit 'playerConnect', new Player(socket, world)

  # TODO: error handling

  # World生成
  _.each _.range(2), (i) ->
    world = new World 'world_' + i, 20, io
    world.run()
    worlds.push world

  process.on 'uncaughtException', (e) ->
    console.log 'uncaughtException' + e

main()