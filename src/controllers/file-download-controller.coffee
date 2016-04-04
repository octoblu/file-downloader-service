request = require 'request'

class FileDownloadController
  constructor: ->

  download: (req, res) =>
    {uri, fileName} = req.query
    res.setHeader 'content-disposition', "filename=#{fileName}" if fileName?
    stream = request.get uri
    stream.pipe res

module.exports = FileDownloadController
