// Generated by CoffeeScript 1.9.2
(function() {
  var SpecReporter, TestProcessor;

  require('./helpers/test-helper.coffee');

  SpecReporter = require('../src/lawl-spec-reporter.js');

  TestProcessor = require('./helpers/test-processor.js');

  describe('spec reporter', function() {
    addMatchers();
    return describe('with custom processor', function() {
      beforeEach(function() {
        return this.reporter = new SpecReporter({
          displayPendingSpec: true,
          customProcessors: [TestProcessor],
          test: ' TEST'
        });
      });
      describe('when suite', function() {
        return it('should report suite with custom display', function() {
          return expect(new Test(this.reporter, function() {
            return this.describe('suite', function() {
              return this.it('successful spec', function() {
                return this.passed();
              });
            });
          }).outputs).contains(/SUITE TEST/);
        });
      });
      return describe('when spec', function() {
        it('should report success with custom display', function() {
          return expect(new Test(this.reporter, function() {
            return this.describe('suite', function() {
              return this.it('successful spec', function() {
                return this.passed();
              });
            });
          }).outputs).contains(/SUCCESSFUL SPEC TEST/);
        });
        it('should report failure with custom display', function() {
          return expect(new Test(this.reporter, function() {
            return this.describe('suite', function() {
              return this.it('failed spec', function() {
                return this.failed();
              });
            });
          }).outputs).contains(/FAILD SPEC TEST/);
        });
        return it('should report pending with custom display', function() {
          return expect(new Test(this.reporter, function() {
            return this.describe('suite', function() {
              return this.xit('pending spec', function() {});
            });
          }).outputs).contains(/PENDING SPEC TEST/);
        });
      });
    });
  });

}).call(this);

//# sourceMappingURL=custom-processor.spec.js.map
