request = require 'request'

class GithubReleaseController
  constructor: ->

  download: (req, res) =>
    { owner, repo, tag, asset } = req.params
    uri = "https://github.com/#{owner}/#{repo}/releases/download/#{tag}/#{asset}"
    request
      .get uri
      .pipe res

module.exports = GithubReleaseController
