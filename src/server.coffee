cors               = require 'cors'
morgan             = require 'morgan'
express            = require 'express'
bodyParser         = require 'body-parser'
OctobluRaven       = require 'octoblu-raven'
compression        = require 'compression'
enableDestroy      = require 'server-destroy'
expressVersion     = require 'express-package-version'
sendError          = require 'express-send-error'
meshbluHealthcheck = require 'express-meshblu-healthcheck'
debug              = require('debug')('file-downloader-service:server')
Router             = require './router'

class Server
  constructor: ({@disableLogging, @port, @octobluRaven})->
    @octobluRaven ?= new OctobluRaven

  address: =>
    @server.address()

  run: (callback) =>
    app = express()
    app.use compression()
    ravenExpress = @octobluRaven.express()
    app.use ravenExpress.handleErrors()
    app.use sendError()
    app.use meshbluHealthcheck()
    skip = (request, response) =>
      return response.statusCode < 400
    app.use morgan 'dev', { immediate: false, skip } unless @disableLogging
    app.use expressVersion({format: '{"version": "%s"}'})
    app.use cors()
    app.use bodyParser.urlencoded limit: '1mb', extended : true
    app.use bodyParser.json limit : '1mb'

    app.options '*', cors()

    router = new Router {}

    router.route app

    @server = app.listen @port, callback
    enableDestroy @server

  stop: (callback) =>
    @server.close callback

  destroy: =>
    @server.destroy()

module.exports = Server
