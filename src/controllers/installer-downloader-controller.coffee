_       = require 'lodash'
request = require 'request'

ARCHS_64=['x64', 'amd64']
ARCHS_32=['386', 'ia32']
ARCHS_ARM=['armv7l', 'arm']

is64 = (arch) =>
  return arch in ARCHS_64

is32 = (arch) =>
  return arch in ARCHS_32

isArm = (arch) =>
  return arch in ARCHS_ARM

class InstallerDownloaderController
  constructor: ->

  download: (req, res) =>
    { owner, repo, tag, os, arch } = req.params
    { fileName } = req.query
    request.get "https://connector.octoblu.com/github/#{owner}/#{repo}", {json: true}, (error, response, body) =>
      return res.status(500).send error: error.message if error?
      return res.status(response.statusCode).send error: 'unable to get latest' if response.statusCode > 299
      tags = _.get body, 'tags', {}
      release = @getCorrectRelease { tags, os, arch }
      return res.status(404).send error: 'unable to find release' unless release?
      @_download { owner, repo, tag: release.tag, asset: release.asset, fileName }, res

  getCorrectRelease: ({ tags, os, arch }) =>
    return null if _.isEmpty tags
    tags = _.values tags
    tags = _.filter tags, ({ prerelease, draft }) =>
      return false if prerelease || draft
      return true
    for tag in tags
      return @getAssetForMac tag if @isMac { os }
      return @getAssetForWindows tag, { arch } if @isWindows { os }
      return @getAssetForLinux tag, { arch } if @isLinux { os }

  isMac: ({ os }) =>
    return os in ['darwin', 'mac', 'macos', 'macosx', 'osx']

  isWindows: ({ os }) =>
    return os in ['windows', 'win']

  isLinux: ({ os }) =>
    return os in ['linux']

  getAssetForMac: ({ tag, assets }) =>
    return if _.isEmpty assets
    for { name } in assets
      return { asset: name, tag } if _.endsWith name, '.dmg'

  getAssetForWindows: ({ tag, assets }, { arch }) =>
    return if _.isEmpty assets
    for { name } in assets
      return { asset: name, tag } if is32(arch) and _.endsWith name, "-ia32-win.zip"
      return { asset: name, tag } if is32(arch) and _.endsWith name, "-windows-386.zip"
      return { asset: name, tag } if is64(arch) and _.endsWith name, "-windows-amd64.zip"
      return { asset: name, tag } if is64(arch) and _.endsWith(name, "-win.zip") and !_.endsWith(name, "-ia32-win.zip")

  getAssetForLinux: ({ tag, assets }, { arch }) =>
    return if _.isEmpty assets
    for { name } in assets
      continue if _.endsWith name, '-win.zip'
      return { asset: name, tag } if is32(arch) and _.endsWith name, "-linux-386.zip"
      return { asset: name, tag } if is64(arch) and _.endsWith name, "-linux-amd64.zip"
      return { asset: name, tag } if isArm(arch) and _.endsWith name, "-linux-arm.zip"
      return { asset: name, tag } if is32(arch) and _.endsWith name, "-ia32.zip"
      return { asset: name, tag } if isArm(arch) and _.endsWith name, "-armv7l.zip"
      return { asset: name, tag } if is64(arch) and !_.includes(name, '-linux-') and _.endsWith(name, ".zip")

  _download: ({ owner, repo, tag, asset, fileName }, res) =>
    uri = "https://github.com/#{owner}/#{repo}/releases/download/#{tag}/#{asset}"
    disposition = "attachment; filename=#{fileName}" if fileName?
    request
      .get uri, { gzip: true }
      .on 'response', (response) =>
        response.headers['content-disposition'] = disposition if fileName?
      .pipe res

module.exports = InstallerDownloaderController
