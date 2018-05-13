//
//  SpeechHandler.swift
//  DevChallenge12
//
//  Created by " " on 5/12/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit
import Speech

class SpeechHandler {
    static var speechManager: SpeechHandler = SpeechHandler()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var rekognationTask: SFSpeechRecognitionTask?


    func registerSpeechRecognizer()  {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    print("authorized")
                case .denied:
                    print("denied")
                case .restricted:
                    print("restricted")
                case .notDetermined:
                    print("notDetermined")
                }
            }
        }
    }

    func runSpeechManager() {

    }

    func startRecording(_ snake: SnakeBody) throws {
        if let recognTask = rekognationTask {
            recognTask.cancel()
            self.rekognationTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode
        guard let recionRequest = recognitionRequest else { fatalError("recognationRequest / SpeechHendler.swift") }

        rekognationTask = speechRecognizer.recognitionTask(with: recionRequest) { result, error in
            var isFinal = false
            if let result = result {
            let str = result.bestTranscription.formattedString
            let strArray = str.components(separatedBy: " ")
                if let lastW = strArray.last {
                    if lastW == "left" || lastW == "Left" {
                        snake.actions.turnLeft(snake: snake)
                    } else if lastW == "right" || lastW == "Right" {
                        snake.actions.turnRight(snake: snake)
                    }
                    isFinal = result.isFinal
                }
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.rekognationTask = nil
            }
        }
        let recordFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFormat) { (buffer: AVAudioPCMBuffer, when:AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
    }

    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, aviabilityDidChange avilable: Bool) -> Bool {
        if avilable {
            return true
        }
        return false
    }

    func stopRecording(_ snake: SnakeBody) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
        } else {
            try! startRecording(snake)
        }
    }

    private init() {

    }


}
