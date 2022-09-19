//
//  BookmarkViewModel.swift
//  Presantation
//
//  Created by cheonsong on 2022/09/19.
//

import Foundation
import Domain

public class BookmarkViewModel {
    
    private var usecase: RequestCurrentWeatherUsecase
    
    public init(usecase: RequestCurrentWeatherUsecase) {
        self.usecase = usecase
    }
}
