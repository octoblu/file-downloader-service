request = require 'request'

class FileDownloadController
  constructor: ->

  download: (req, res) =>
    {uri, url, fileName} = req.query
    url ?= uri if uri?
    unless url?
      error = new Error 'Missing url in query string'
      error.code = 422
      return res.sendError error
    disposition = "attachment; filename=#{fileName}" if fileName?
    request
      .get uri, { gzip: true }
      .on 'response', (response) =>
        response.headers['content-disposition'] = disposition if fileName?
      .pipe res

module.exports = FileDownloadController
