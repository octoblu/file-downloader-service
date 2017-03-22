Server = require '../../src/server'

describe 'Server', ->
  beforeEach ->
    @sut = new Server { port: undefined }

  afterEach ->
    @sut.destroy()

  describe '->run', ->
    beforeEach (done) ->
      @sut.run (@error) =>
        done()

    it 'should not have an error', ->
      expect(@error).to.not.exist
