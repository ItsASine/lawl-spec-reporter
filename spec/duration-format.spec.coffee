SpecReporter = require('../src/lawl-spec-reporter.js')

describe 'duration', ->
  it 'should be human readable', ->
    secs = 1000
    mins = 60 * secs
    hours = 60 * mins
    reporter = new SpecReporter()
    @formatDuration = reporter.metrics.formatDuration
    expect(@formatDuration(0)).toBe '0 SECZ'
    expect(@formatDuration(10)).toBe '0.01 SECZ'
    expect(@formatDuration(999)).toBe '0.999 SECZ'
    expect(@formatDuration(secs)).toBe '1 SECZ'
    expect(@formatDuration(10 * secs)).toBe '10 SECZ'
    expect(@formatDuration(59 * secs)).toBe '59 SECZ'
    expect(@formatDuration(60 * secs)).toBe '1 MINZ'
    expect(@formatDuration(61 * secs)).toBe '1 MINZ 1 SECZ'
    expect(@formatDuration(59 * mins)).toBe '59 MINZ'
    expect(@formatDuration(60 * mins)).toBe '1 HRZ'
    expect(@formatDuration(3 * hours + 28 * mins + 53 * secs + 127)).toBe '3 HRZ 28 MINZ 53 SECZ'
    expect(@formatDuration(3 * hours + 53 * secs + 127)).toBe '3 HRZ 53 SECZ'
