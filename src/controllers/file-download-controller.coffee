request = require 'request'

class FileDownloadController
  constructor: ->

  download: (req, res) =>
    {uri, fileName} = req.query
    disposition = "attachment; filename=#{fileName}"
    request
      .get uri
      .on 'response', (response) =>
        response.headers['content-disposition'] = disposition;
      .pipe res

module.exports = FileDownloadController
