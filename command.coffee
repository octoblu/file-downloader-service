_             = require 'lodash'
OctobluRaven  = require 'octoblu-raven'
Server        = require './src/server'

class Command
  constructor: ->
    @octobluRaven = new OctobluRaven()
    @serverOptions =
      port:           process.env.PORT || 80
      disableLogging: process.env.DISABLE_LOGGING == "true"
      octobluRaven:   @octobluRaven

  panic: (error) =>
    console.error error.stack
    process.exit 1

  catchErrors: =>
    @octobluRaven.patchGlobal()

  run: =>
    server = new Server @serverOptions
    server.run (error) =>
      return @panic error if error?
      {port} = server.address()
      console.log "File downloader service listening on port #{port}"

    process.on 'SIGTERM', =>
      console.log 'SIGTERM caught, exiting'
      server.stop =>
        process.exit 0

command = new Command()
command.catchErrors()
command.run()
