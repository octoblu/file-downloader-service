_       = require 'lodash'
request = require 'request'

class GithubReleaseController
  constructor: ->

  download: (req, res) =>
    { owner, repo, tag, asset } = req.params
    { fileName } = req.query
    request.get "https://connector.octoblu.com/github/#{owner}/#{repo}", {json: true}, (error, response, body) =>
      return res.status(500).send error: error.message if error?
      return res.status(response.statusCode).send error: 'unable to get latest' if response.statusCode > 299
      foundTag = tag if body.tags[tag]?
      foundTag = body.latest.tag if !foundTag? && tag == 'latest'
      return res.status(404).send error: 'unable to find tag' unless foundTag?
      return res.status(404).send error: 'unable to find asset' unless _.find body.tags[foundTag].assets, { name: asset }
      @_download { owner, repo, tag: foundTag, asset, fileName }, res

  _download: ({ owner, repo, tag, asset, fileName }, res) =>
    uri = "https://github.com/#{owner}/#{repo}/releases/download/#{tag}/#{asset}"
    disposition = "attachment; filename=#{fileName}" if fileName?
    request
      .get uri, { gzip: true }
      .on 'response', (response) =>
        response.headers['content-disposition'] = disposition if fileName?
      .pipe res

module.exports = GithubReleaseController
