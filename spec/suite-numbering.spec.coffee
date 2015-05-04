require('./helpers/test-helper.coffee')
SpecReporter = require('../src/jasmine-spec-reporter.js')

describe 'spec reporter', ->
  addMatchers()

  describe 'with suite number enabled', ->
    beforeEach ->
      @reporter = new SpecReporter(displaySuiteNumber: true)

    describe 'when single suite', ->
      it 'should add suite number', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs)
        .contains /1 SUITE/

    describe 'when multiple suite', ->
      it 'should add suite number', ->
        outputs = new Test(@reporter,->
          @describe 'first suite', ->
            @it 'successful spec', ->
              @passed()
          @describe 'second suite', ->
            @it 'successful spec', ->
              @passed()
          @describe 'third suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs
        expect(outputs).contains /1 FURST SUITE/
        expect(outputs).contains /2 SECOND SUITE/
        expect(outputs).contains /3 THIRD SUITE/

    describe 'when multiple nested suite', ->
      it 'should add suite number', ->
        outputs = new Test(@reporter,->
          @describe 'first suite', ->
            @describe 'first child suite', ->
              @describe 'first grandchild suite', ->
                @it 'successful spec', ->
                  @passed()
              @describe 'second grandchild suite', ->
                @it 'successful spec', ->
                  @passed()
            @describe 'second child suite', ->
              @it 'successful spec', ->
                @passed()
        ).outputs
        expect(outputs).contains /1 FURST SUITE/
        expect(outputs).contains /1.1 FURST CHILD SUITE/
        expect(outputs).contains /1.1.1 FURST GRANDCHILD SUITE/
        expect(outputs).contains /1.1.2 SECOND GRANDCHILD SUITE/
        expect(outputs).contains /1.2 SECOND CHILD SUITE/
