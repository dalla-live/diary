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
    var subtitleData: PublishSubject<JSON> {get}
}


public class VideoViewModel: VideoSubtitleViewModelOutput{
    var subtitleData: PublishSubject<JSON> = .init()
    
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
                self?.subtitleData.onNext(model)
            case .failure(let error):
                Log.e(error)
            }
        }
    }
}
