//
//  SpeechRecognizer.swift
//  Service
//
//  Created by inforex on 2022/09/27.
//

import Foundation
import Speech
    
public protocol SpeechRecognizeService: AnyObject {
    func recognizeStop()
    func recognizeStart()
    func recognizing(text: String?)
    func recognizePause()
}
    
public class SpeechRecognizer: NSObject, SFSpeechRecognizerDelegate {
    
    public typealias RecognitionResponse = (Result<SFSpeechRecognitionResult?, Error>)
    
    private var recognizer = SFSpeechRecognizer() // 인식기
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // 음성인식 요청 처리
    private var recognitionTask: SFSpeechRecognitionTask? // 인식 요청 결과 제공
    private let audioEngine = AVAudioEngine() // 소리 인식 오디오 엔진
    public weak var delegate : SpeechRecognizeService?
    
    public override init(){
        super.init()
        
        let identifier: String = Locale.preferredLanguages.first ?? "ko-KR"
        self.recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: identifier))
        self.recognizer?.delegate = self
    }
    
    public func speechToText(){
        if audioEngine.isRunning {
            stopRecording()
        } else {
            startRecording()
            delegate?.recognizeStart()
        }
    }
    
    public func stopRecording(){
        audioEngine.stop() // 오디오 입력 중단
        recognitionRequest?.endAudio() // 음성인식 중단
        delegate?.recognizeStop()
    }
    
    
    public func startRecording(){
        // 인식 작업이 실행 중인지 확인. 이 경우 작업과 인식 취소
        if recognitionTask != nil{
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // 오디오 녹음을 준비 할 AVAudioSession을 만든다.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        
        // recognitionRequest 객체가 인스턴스화되고 nil이 아닌지 확인
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequst object")
        }
        
        // audioEngine(장치)에 녹음할 오디오 입력이 있는지 확인.
        let inputNode = audioEngine.inputNode
        
        // 사용자가 말할 때 인식의 부분적인 결과를 보고하도록 recognitionRequst에 지시
        recognitionRequest.shouldReportPartialResults = true
        
        //
        recognitionTask = recognizer?.recognitionTask(with: recognitionRequest, resultHandler: {[weak self] (result, error) in
            guard let self = self else { return }
            var isFinal = false // 최종인식 Flag
            let result = result
            if result != nil {
                
                isFinal = (result?.isFinal)!
                self.delegate?.recognizing(text: result?.bestTranscription.formattedString)
            }
            // 오류가 없거나 최종 결과가 나오면 audioEngine(오디오 입력)을 중지하고 인식 요청 및 인식 작업 중지, 녹음 버튼 활성화.
            if error != nil || isFinal {
                self.audioEngine.stop()
                
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.delegate?.recognizePause()
            }
        })
        //recognitionRequest에 오디오 입력을 추가. 인식 작업을 시작한 후에는 오디오 입력을 추가해도 괜찮습니다. 오디오 프레임 워크는 오디오 입력이 추가되는 즉시 인식을 시작합니다.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {[weak self] (buffer, when) in
            guard let self = self else { return }
            self.recognitionRequest?.append(buffer)
        }
        
        // Prepare and start the audioEngine.
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
}
