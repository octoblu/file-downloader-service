_ = require 'lodash'
InstallerDownloaderController = require '../../src/controllers/installer-downloader-controller'
exampleTags = require './assets/example-electron-result.json'

getExampleTags = =>
  return _.cloneDeep(exampleTags)

describe 'InstallerDownloaderController', ->
  beforeEach ->
    @sut = new InstallerDownloaderController

  describe '->getCorrectRelease', ->
    describe 'when called with no tags', ->
      beforeEach ->
        @result = @sut.getCorrectRelease({ })

      it 'should not have a result', ->
        expect(@result).to.not.exist

    describe 'when called with all types of mac os names', ->
      describe 'v2.0.0', ->
        beforeEach ->
          @results = []
          tags = getExampleTags()
          for os in ['darwin', 'mac', 'macos', 'macosx', 'osx']
            @results.push @sut.getCorrectRelease({
              tags,
              os,
              arch: 'x64'
            })

        it 'should the correct result for all oss', ->
          expect(@results).to.deep.equal [
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0.dmg" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0.dmg" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0.dmg" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0.dmg" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0.dmg" }
          ]

      describe 'v1.0.0', ->
        beforeEach ->
          @results = []
          tags = getExampleTags()
          delete tags['v2.0.0']
          for os in ['darwin', 'mac', 'macos', 'macosx', 'osx']
            @results.push @sut.getCorrectRelease({
              tags,
              os,
              arch: 'x64'
            })

        it 'should the correct result for all oss', ->
          expect(@results).to.deep.equal [
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-darwin-amd64.dmg" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-darwin-amd64.dmg" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-darwin-amd64.dmg" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-darwin-amd64.dmg" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-darwin-amd64.dmg" }
          ]

    describe 'when called with all types of win os and arch names', ->
      describe 'v2.0.0', ->
        beforeEach ->
          @results = []
          tags = getExampleTags()
          for os in ['windows', 'win']
            for arch in ['386', 'ia32', 'amd64', 'x64']
              @results.push @sut.getCorrectRelease({
                tags,
                os,
                arch
              })

        it 'should the correct result for all oss', ->
          expect(@results).to.deep.equal [
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-ia32-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-ia32-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-ia32-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-ia32-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-win.zip" }
            { tag: "v2.0.0", asset: "MeshbluConnectorInstaller-2.0.0-win.zip" }
          ]

      describe 'v1.0.0', ->
        beforeEach ->
          @results = []
          tags = getExampleTags()
          delete tags['v2.0.0']
          for os in ['windows', 'win']
            for arch in ['386', 'ia32', 'amd64', 'x64']
              @results.push @sut.getCorrectRelease({
                tags,
                os,
                arch
              })

        it 'should the correct result for all oss', ->
          expect(@results).to.deep.equal [
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-386.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-386.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-amd64.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-amd64.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-386.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-386.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-amd64.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-windows-amd64.zip" }
          ]

    describe 'when called with all types of linux os and arch names', ->
      describe 'v2.0.0', ->
        beforeEach ->
          @results = []
          tags = getExampleTags()
          for arch in ['386', 'ia32', 'amd64', 'x64', 'arm', 'armv7l']
            @results.push @sut.getCorrectRelease({
              tags,
              os: 'linux',
              arch
            })

        it 'should the correct result for all oss', ->
          expect(@results).to.deep.equal [
            { tag: "v2.0.0", asset: "electron-meshblu-connector-installer-2.0.0-ia32.zip" }
            { tag: "v2.0.0", asset: "electron-meshblu-connector-installer-2.0.0-ia32.zip" }
            { tag: "v2.0.0", asset: "electron-meshblu-connector-installer-2.0.0.zip" }
            { tag: "v2.0.0", asset: "electron-meshblu-connector-installer-2.0.0.zip" }
            { tag: "v2.0.0", asset: "electron-meshblu-connector-installer-2.0.0-armv7l.zip" }
            { tag: "v2.0.0", asset: "electron-meshblu-connector-installer-2.0.0-armv7l.zip" }
          ]

      describe 'v1.0.0', ->
        beforeEach ->
          @results = []
          tags = getExampleTags()
          delete tags['v2.0.0']
          for arch in ['386', 'ia32', 'amd64', 'x64', 'arm', 'armv7l']
            @results.push @sut.getCorrectRelease({
              tags,
              os: 'linux',
              arch
            })

        it 'should the correct result for all oss', ->
          expect(@results).to.deep.equal [
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-linux-386.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-linux-386.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-linux-amd64.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-linux-amd64.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-linux-arm.zip" }
            { tag: "v1.0.0", asset: "MeshbluConnectorInstaller-linux-arm.zip" }
          ]
