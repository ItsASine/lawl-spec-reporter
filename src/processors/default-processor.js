'use strict';

var DisplayProcessor = require('../display-processor');
var translator = require('../translation.json');

var convert = function(desc) {
    var translation = translator.lolspeak;
    var words = desc.split(" ");

    for ( var i = 0; i < words.length; i++ ) {
        var currentWord = words[i];
        currentWord = currentWord.toLowerCase();
        if ( translation.hasOwnProperty(currentWord) ) {
            words[i] = translation[currentWord];
        }
    }

    var newDesc = words.join(" ");
    newDesc = newDesc.toUpperCase();
    return newDesc;
};

function DefaultProcessor() {}

DefaultProcessor.prototype = new DisplayProcessor();

DefaultProcessor.prototype.displaySuite = function (suite) {
    var desc = suite.description;
    var newDesc = convert(desc);

    return newDesc;
};

function displaySpecDescription(spec) {
    var desc = spec.description;
    var newDesc = convert(desc);

    return newDesc;
}

DefaultProcessor.prototype.displaySuccessfulSpec = displaySpecDescription;
DefaultProcessor.prototype.displayFailedSpec = displaySpecDescription;
DefaultProcessor.prototype.displayPendingSpec = displaySpecDescription;

module.exports = DefaultProcessor;
