//
//  VideoViewModel.swift
//  Presantation
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import Domain
import RxSwift
import Util
import SwiftyJSON
import Service

// input
protocol VideoSubtitleViewModelInput {
    func requestVideoSubtitle(url: URL)
}
// output
protocol VideoSubtitleViewModelOutput {
    var subtitleData: PublishSubject<(SubtitleData,URL)> {get}
    var errorMessage: PublishSubject<String> {get}
}


public class VideoViewModel: VideoSubtitleViewModelOutput{
    var subtitleData: PublishSubject<(SubtitleData,URL)> = .init()
    var errorMessage: PublishSubject<String> = .init()
    
    private var usecase: RequestVideoSubtitleUseCase
    
    public init(usecase: RequestVideoSubtitleUseCase) {
        self.usecase = usecase
    }
}

extension VideoViewModel: VideoSubtitleViewModelInput{
    func requestVideoSubtitle(url: URL) {
        usecase.execute(request: url) {[weak self] (result) in
            switch result {
            case .success(let model):
                
                if let subtitles = try? JSONDecoder().decode(SubtitleData.self, from: model.rawData()){
                    self?.subtitleData.onNext((subtitles, url))
                }
            case .failure(let error):
                Log.e(error)
                self?.errorMessage.onNext("자막 생성작업을 실패하였습니다.\n 잠시 후 다시 시도해주세요.")
            }
        }
    }
}
