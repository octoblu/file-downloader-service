FileDownloadController = require './controllers/file-download-controller'

class Router
  constructor: ({@fileDownloadService}) ->
  route: (app) =>
    fileDownloadController = new FileDownloadController {@fileDownloadService}

    app.get '/download', fileDownloadController.download
module.exports = Router
