
lawl-spec-reporter  [![Build Status](https://travis-ci.org/ItsASine/lawl-spec-reporter.svg?branch=develop)](https://travis-ci.org/ItsASine/lawl-spec-reporter)
========================

#OHAI

##Description

Spec reporter for jasmine, based on [jasmine-spec-reporter](https://raw.github.com/bcaudan/jasmine-spec-reporter/), outputs in LolSpeak

![Screenshot](/screenshot.png)

## Usage
### Protractor
The `lawl-spec-reporter` can be used to enhance your [Protractor](https://github.com/angular/protractor) tests execution report, utilizing the power of lulz.

###Customization

Have some project-specific words that you know could be lolified? Add them to the [translation.json](/src/translation.json) file!

##Credit

* [LolSpeak translator](https://code.google.com/p/pylolz/), for the base translation file.
* [jasmine-spec-reporter](https://raw.github.com/bcaudan/jasmine-spec-reporter/), for the vast majority of the base work

So, yeah, all I did was put it together and made it work :+1:

##Project Status

###1.0

Currently will take your suite and spec descriptions and convert them to lolspeak. Also outputs metrics to lolspeak.

###Future versions

- [ ] Make Stacktrace prettier (eww)
- [ ] Get the spec file working instead of just skipping the failures summary tests (note: the failures summary does print, see screenshot, but the test that's testing the tests is not working)
- [ ] Lolified failure summary

##Installation

`npm install lawl-spec-reporter`

#KTHXBAI
