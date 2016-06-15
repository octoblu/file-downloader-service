FileDownloadController = require './controllers/file-download-controller'
GithubReleaseController = require './controllers/github-release-controller'

class Router
  constructor: ({@fileDownloadService}) ->
  route: (app) =>
    fileDownloadController = new FileDownloadController {@fileDownloadService}
    githubReleaseController = new GithubReleaseController {@fileDownloadService}

    app.get '/download', fileDownloadController.download
    app.get '/github-release/:owner/:repo/:tag/:asset', githubReleaseController.download

module.exports = Router
