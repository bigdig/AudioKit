//
//  main.swift
//  AudioKit
//
//  Created by Aurelius Prochazka on 12/21/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//

import Foundation

class Instrument : AKInstrument {

    override init() {
        super.init()

        let note = Note()
        addNoteProperty(note.pan)
        addNoteProperty(note.panMethod)

        let oscillator = AKOscillator()
        connect(oscillator)

        let pan = AKOscillator()
        pan.frequency = 1.ak
        connect(pan)

        let operation = AKPanner(input: oscillator)
        operation.pan = pan
        connect(operation)

        connect(AKAudioOutput(stereoAudioSource:operation))
    }
}

class Note: AKNote {
    var pan = AKNoteProperty()
    var panMethod = AKNoteProperty()

    override init() {
        super.init()
        addProperty(pan)
        self.pan.setValue(0)
        addProperty(panMethod)
        self.panMethod.setValue(0)
    }
}

let instrument = Instrument()
AKOrchestra.addInstrument(instrument)

AKOrchestra.testForDuration(10)

let note1 = Note()
// specify properties and create more notes here

let phrase = AKPhrase()
phrase.addNote(note1, atTime:0.5)
// add more phrase notes here

instrument.playPhrase(phrase)

while(AKManager.sharedManager().isRunning) {} //do nothing
println("Test complete!")
