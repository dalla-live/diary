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

// input
protocol VideoSubtitleViewModelInput {
    func requestVideoSubtitle(url: URL)
}
// output
protocol VideoSubtitleViewModelOutput {
    var subtitleData: PublishSubject<(SubtitleData,URL)> {get}
}


public class VideoViewModel: VideoSubtitleViewModelOutput{
    var subtitleData: PublishSubject<(SubtitleData,URL)> = .init()
    
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
                
                guard let subtitles = try? JSONDecoder().decode(SubtitleData.self, from: model.rawData()) else { return }
                self?.subtitleData.onNext((subtitles, url))
            case .failure(let error):
                Log.e(error)
            }
        }
    }
}
