FileDownloadController = require './controllers/file-download-controller'
GithubReleaseController = require './controllers/github-release-controller'
InstallerDownloaderController = require './controllers/installer-downloader-controller'

class Router
  constructor: ({@fileDownloadService}) ->
  route: (app) =>
    fileDownloadController = new FileDownloadController
    githubReleaseController = new GithubReleaseController
    installerDownloaderController = new InstallerDownloaderController

    app.get '/download', fileDownloadController.download
    app.get '/github-release/:owner/:repo/:tag/:asset', githubReleaseController.download
    app.get '/installer/:owner/:repo/:os/:arch', installerDownloaderController.download

module.exports = Router
