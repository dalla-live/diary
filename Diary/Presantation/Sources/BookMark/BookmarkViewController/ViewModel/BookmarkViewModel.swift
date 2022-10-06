//
//  BookmarkViewModel.swift
//  Presantation
//
//  Created by chuchu on 2022/10/05.
//

import Foundation
import Domain
import RxSwift
import Util

protocol BookmarkViewModelInput {
    func viewDidload(completion: ((BookmarkList) -> ())?)
    func updateButtonTap(completion: ((BookmarkList) -> ())?)
}

protocol BookmarkViewModelOutput {
    
}

protocol BookmarkViewModelProtocol: BookmarkViewModelInput, BookmarkViewModelOutput { }

public class BookmarkViewModel: BookmarkViewModelProtocol {
    private var BookmarkUseCase: BookmarkUseCase
    private var disposeBag = DisposeBag()
    
    struct Model {
        let weather: Weather
    }
    
    let location = BehaviorSubject<Location>(value: Location(lat: 0, lon: 0, address: ""))
    
    public init(BookmarkBookmarkUseCase: BookmarkUseCase) {
        self.BookmarkUseCase = BookmarkBookmarkUseCase
    }
    
    func viewDidload(completion: ((BookmarkList) -> ())? = nil) {
        BookmarkUseCase.loadBookmarkUseCase.excute(query: .all, page: -1) {
            completion?($0)
        }
    }
    
    func updateButtonTap(completion: ((BookmarkList) -> ())? = nil) {
        BookmarkUseCase.loadBookmarkUseCase.excute(query: .all, page: -1) {
            completion?($0)
        }
    }
    
    
    deinit {
        print(#file.fileName, #function)
    }
}

public struct BookmarkUseCase {
    let loadBookmarkUseCase: LoadBookmarkUseCase
    
    public init(loadBookmarkUseCase: LoadBookmarkUseCase) {
        self.loadBookmarkUseCase = loadBookmarkUseCase
    }
}
