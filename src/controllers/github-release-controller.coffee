request = require 'request'

class GithubReleaseController
  constructor: ->

  download: (req, res) =>
    { owner, repo, tag, asset } = req.params
    if tag == 'latest'
      return @_getLatestAndDownload { owner, repo, asset }, res
    @_download { owner, repo, tag, asset }, res

  _getLatestAndDownload: ({ owner, repo, asset }, res) =>
    request.get "https://connector.octoblu.com/github/#{owner}/#{repo}", {json: true}, (error, response, body) =>
      return res.status(500).send error: error.message if error?
      return res.status(404).send error: 'unable to get latest' if response.statusCode > 299
      { tag } = body.latest
      @_download { owner, repo, tag, asset }, res

  _download: ({ owner, repo, tag, asset }, res) =>
    uri = "https://github.com/#{owner}/#{repo}/releases/download/#{tag}/#{asset}"
    request
      .get uri
      .pipe res

module.exports = GithubReleaseController
