require('./helpers/test-helper.coffee')
SpecReporter = require('../src/jasmine-spec-reporter.js')

describe 'spec reporter', ->
  addMatchers()

  describe 'with default options', ->
    beforeEach ->
      @reporter = new SpecReporter()

    describe 'when spec', ->
      it 'should report success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs)
        .contains /✓ SUCCESSFUL SPEC/


      it 'should report failure', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed()
        ).outputs)
        .contains /✗ FAILD SPEC/


      it 'should not report pending', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @xit 'pending spec', ->
        ).outputs)
        .not.contains /PENDING SPEC/


    describe 'when failed spec', ->
      it 'should display with error messages', ->
        outputs = new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed('first failed assertion')
              @passed('passed assertion')
              @failed('second failed assertion')
        ).outputs

        expect(outputs).not.contains /passed assertion/
        expect(outputs).contains [
          '    ✗ FAILD SPEC'
          '      - first failed assertion'
          '      - second failed assertion'
          ''
        ]


    describe 'when suite', ->
      it 'should display multiple specs', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'spec 1', ->
              @passed()
            @it 'spec 2', ->
              @passed()
        ).outputs).contains [
          ''
          '  SUITE'
          '    ✓ SPEC 1'
          '    ✓ SPEC 2'
          ''
        ]


      it 'should display multiple suites', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @it 'spec 1', ->
              @passed()
          @describe 'suite 2', ->
            @it 'spec 2', ->
              @passed()
        ).outputs).contains [
          ''
          '  SUITE 1'
          '    ✓ SPEC 1'
          ''
          '  SUITE 2'
          '    ✓ SPEC 2'
          ''
        ]


      it 'should display nested suite at first position', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @describe 'suite 2', ->
              @it 'spec 1', ->
                @passed()
            @it 'spec 2', ->
              @passed()
        ).outputs).contains [
          ''
          '  SUITE 1'
          ''
          '    SUITE 2'
          '      ✓ SPEC 1'
          ''
          '    ✓ SPEC 2'
          ''
        ]


      it 'should display nested suite at last position', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @it 'spec 1', ->
              @passed()
            @describe 'suite 2', ->
              @it 'spec 2', ->
                @passed()
        ).outputs).contains [
          ''
          '  SUITE 1'
          '    ✓ SPEC 1'
          ''
          '    SUITE 2'
          '      ✓ SPEC 2'
          ''
        ]


      it 'should display multiple nested suites', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @describe 'suite 2', ->
              @it 'spec 2', ->
                @passed()
            @describe 'suite 3', ->
              @it 'spec 3', ->
                @passed()
        ).outputs).contains [
          ''
          '  SUITE 1'
          ''
          '    SUITE 2'
          '      ✓ SPEC 2'
          ''
          '    SUITE 3'
          '      ✓ SPEC 3'
          ''
        ]


    describe 'when summary', ->
      it 'should report success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'spec', ->
              @passed()
        ).summary)
        .contains 'EXECUTD 1 OV 1 SPEC SUCCES IN {time}.'


      it 'should report failure', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'spec', ->
              @failed()
        ).summary)
        .contains 'EXECUTD 1 OV 1 SPEC (1 FAILD) IN {time}.'

      #TODO: Make this work
      xit 'should report failures summary', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @it 'spec 1', ->
              @failed('failed assertion 1')
            @describe 'suite 2', ->
              @it 'spec 2', ->
                @failed('failed assertion 2')
        ).summary).contains [
          /[\s\S]*/
          /OH NOES/
          /[\s\S]*/
          /1\) SUITE 1 SPEC 1/
          /- failed assertion 1/
          /[\s\S]*/
        ]


      it 'should report pending with success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @xit 'spec', ->
        ).summary)
        .contains 'EXECUTD 0 OV 1 SPEC SUCCES (1 PENDIN) IN {time}.'


      it 'should report pending with failure', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @xit 'spec', ->
            @it 'spec', ->
              @failed()
        ).summary)
        .contains 'EXECUTD 1 OV 2 SPECZ (1 FAILD) (1 PENDIN) IN {time}.'


      xit 'should report skipped with success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'spec', ->
            @fit 'spec', ->
        ).summary)
        .toContain 'EXECUTD 1 OV 1 SPEC SUCCES (1 SKIPPED) IN {time}.'


      xit 'should report skipped with failure and pending', ->
        expect(new Test(@reporter,->
          @fdescribe 'suite', ->
            @xit 'spec', ->
            @it 'spec', ->
              @failed()
          @describe 'suite', ->
            @it 'spec', ->
            @xit 'spec', ->
        ).summary)
        .toContain 'EXECUTD 1 OV 2 SPECZ (1 FAILD) (1 PENDING) (2 SKIPPED) IN {time}.'


  describe 'with stacktrace enabled', ->
    beforeEach ->
      @reporter = new SpecReporter({displayStacktrace: true})

    describe 'when failed spec', ->
      it 'should display with error messages with stacktraces', ->
        outputs = new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed('first failed assertion')
        ).outputs

        expect(outputs).not.contains /passed assertion/
        expect(outputs).contains [
          '    ✗ FAILD SPEC'
          '      - first failed assertion'
          '      {Stacktrace}'
          ''
        ]

        #TODO: Make this work
    describe 'when summary', ->
      xit 'should report failures summary with stacktraces', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @it 'spec 1', ->
              @failed('failed assertion 1')
            @describe 'suite 2', ->
              @it 'spec 2', ->
                @failed('failed assertion 2')
        ).summary).contains [
          /[\s\S]*/
          /OH NOES/
          /[\s\S]*/
          /1\) SUITE 1 SPEC 1/
          /- failed assertion 1/
          '  {Stacktrace}'
          /[\s\S]*/
        ]


  describe 'with failures summary disabled', ->
    beforeEach ->
      @reporter = new SpecReporter({displayFailuresSummary: false})

    describe 'when summary', ->
      it 'should not report failures summary', ->
        expect(new Test(@reporter,->
          @describe 'suite 1', ->
            @it 'spec 1', ->
              @failed('failed assertion 1')
            @describe 'suite 2', ->
              @it 'spec 2', ->
                @failed('failed assertion 2')
        ).summary).not.contains /OH NOES/


  describe 'with successful spec disabled', ->
    beforeEach ->
      @reporter = new SpecReporter({displaySuccessfulSpec: false})

    describe 'when spec', ->
      it 'should not report success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs)
        .not.contains /SUCCESSFUL SPEC/


    describe 'when suite', ->
      it 'should not display successful suite', ->
        outputs = new Test(@reporter,->
          @describe 'suite', ->
            @it 'spec 1', ->
              @passed()
            @it 'spec 2', ->
              @passed()
        ).outputs

        expect(outputs).not.contains /SUITE/


      it 'should display failed suite', ->
        outputs = new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed()
            @it 'successful spec', ->
              @passed()
        ).outputs

        expect(outputs).contains /SUITE/
        expect(outputs).contains /FAILD SPEC/
        expect(outputs).not.contains /SUCCESSFUL SPEC/


  describe 'with failed spec disabled', ->
    beforeEach ->
      @reporter = new SpecReporter({displayFailedSpec: false})

    describe 'when spec', ->
      it 'should not report failed', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed()
        ).outputs)
        .not.contains /FAILD SPEC/


    describe 'when suite', ->
      it 'should not display fully failed suite', ->
        expect(new Test(@reporter,->
          @describe 'failed suite', ->
            @it 'spec 1', ->
              @failed()
            @it 'spec 2', ->
              @failed()
        ).outputs).not.contains /FAILD SUITE/


      it 'should display not fully failed suite', ->
        outputs = new Test(@reporter,->
          @describe 'failed suite', ->
            @it 'successful spec', ->
              @passed()
            @it 'failed spec', ->
              @failed()
        ).outputs

        expect(outputs).contains /FAILD SUITE/
        expect(outputs).contains /SUCCESSFUL SPEC/
        expect(outputs).not.contains /FAILD SPEC/


  describe 'with pending spec enabled', ->
    beforeEach ->
      @reporter = new SpecReporter({displayPendingSpec: true})

    describe 'when spec', ->
      it 'should report pending', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @xit 'pending spec', ->
        ).outputs)
        .contains /- PENDING SPEC/


  describe 'with spec duration enabled', ->
    beforeEach ->
      @reporter = new SpecReporter({displaySpecDuration: true})

    describe 'when spec', ->
      it 'should report success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs)
        .contains /✓ SUCCESSFUL SPEC \(\{time}\)/


      it 'should report failure', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed()
        ).outputs)
        .contains /✗ FAILD SPEC \(\{time}\)/


  describe 'with prefixes set to empty strings', ->
    beforeEach ->
      @reporter = new SpecReporter({displayPendingSpec: true, prefixes: {success: '', failure: '', pending: ''}})
 
    describe 'when spec', ->
      it 'should report success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs)
        .not.contains /✓/


      it 'should report failure', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed()
        ).outputs)
        .not.contains /✗/


      it 'should report pending', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @xit 'pending spec', ->
        ).outputs)
        .not.contains /-/


  describe 'with prefixes set to valid strings', ->
    beforeEach ->
      @reporter = new SpecReporter({displayPendingSpec: true, prefixes: {success: 'Pass ', failure: 'Fail ', pending: 'Skip '}})

    describe 'when spec', ->
      it 'should report success', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'successful spec', ->
              @passed()
        ).outputs)
        .not.contains /✓/


      it 'should report failure', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @it 'failed spec', ->
              @failed()
        ).outputs)
        .not.contains /✗/


      it 'should report pending', ->
        expect(new Test(@reporter,->
          @describe 'suite', ->
            @xit 'pending spec', ->
        ).outputs)
        .not.contains /-/
