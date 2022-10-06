//
//  MLKitTranslator.swift
//  ServiceTests
//
//  Created by cheonsong on 2022/10/06.
//

import Foundation
import Util
import MLKitTranslate

public class MLKitTranslator {
    
    public static let shared = MLKitTranslator()
    
    var option: TranslatorOptions!
    var translator: Translator!
    var progress: Progress!
    
    private init() {
        
        NotificationCenter.default.addObserver(
            forName: .mlkitModelDownloadDidSucceed,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            guard let strongSelf = self,
                let userInfo = notification.userInfo,
                let model = userInfo[ModelDownloadUserInfoKey.remoteModel.rawValue]
                    as? TranslateRemoteModel
                else { return }
            // The model was downloaded and is available on the device
            Log.d("\(model.name) 다운로드에 성공했습니다.")
        }

        NotificationCenter.default.addObserver(
            forName: .mlkitModelDownloadDidFail,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            guard let strongSelf = self,
                let userInfo = notification.userInfo,
                let model = userInfo[ModelDownloadUserInfoKey.remoteModel.rawValue]
                    as? TranslateRemoteModel
                else { return }
            let error = userInfo[ModelDownloadUserInfoKey.error.rawValue]
            
            Log.e("\(model.name) 다운로드에 실패했습니다.")
        }
    }
    
    /// MLKit를 사용한 번역
    /// - Parameter completion (translatedText, error)-> Void
    public func translate(source: String, completion: @escaping TranslatorCallback) {
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        translator.downloadModelIfNeeded(with: conditions) { [weak self] error in
            guard let self = self, error == nil else {
                Log.e("번역 모델 로드에 실패했습니다.")
                return
            }
            Log.d("번역 모델 로드에 성공했습니다.")
            
            self.translator.translate(source, completion: completion)
        }
    }
    
    /// MLKit 번역 언어 설정 변경
    /// - Parameters source, target
    public func set (source: TranslateLanguage, target: TranslateLanguage) {
        self.option = TranslatorOptions(sourceLanguage: source, targetLanguage: target)
        self.translator = Translator.translator(options: self.option)
    }
    
    /// 다운로드된 모델 리스트
    public func models()-> Set<TranslateRemoteModel> {
        let localModels = ModelManager.modelManager().downloadedTranslateModels
        return localModels
    }
    
    /// 모델 삭제
    public func deleteModel(target: TranslateLanguage, _ completion: @escaping (Error?)->Void) {
        let deModel = TranslateRemoteModel.translateRemoteModel(language: target)
        ModelManager.modelManager().deleteDownloadedModel(deModel, completion: completion)
    }
    
    /// 모델 다운로드
    public func downloadModel(target: TranslateLanguage) {
        let frModel = TranslateRemoteModel.translateRemoteModel(language: target)
        
        progress = ModelManager.modelManager().download(frModel,
                                                        conditions: ModelDownloadConditions(allowsCellularAccess: false,
                                                                                            allowsBackgroundDownloading: true))
        
    }
    
    deinit {
        Log.d("MLKitTranslator Deinit")
        NotificationCenter.default.removeObserver(self, name: .mlkitModelDownloadDidFail, object: nil)
        NotificationCenter.default.removeObserver(self, name: .mlkitModelDownloadDidSucceed, object: nil)
    }
}
