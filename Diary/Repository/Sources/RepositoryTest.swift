//
//  RepositoryTest.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Util
import RealmSwift
import Domain
import CoreLocation

public class RepositoryTest {
    public init() {
        // MARK: WeatherAPITestCode
        //        WeatherAPI.requestCurrentWeather(request: WeatherDTO(lat: 37.57, lon: 126.85), completion: { (result) in
        //            switch result {
        //            case .success(let model):
        //                Log.d(model)
        //            case .failure(let error):
        //                Log.e(error)
        //            }
        //        })
        //
        // MARK: LocalNameAPITestCode
        //        LocalAPI.requestLocalName(request: LocalDTO(lat: 37.541, lon: 126.980, limit: 1), completion: { (result) in
        //            switch result {
        //            case .success(let model):
        //                Log.d(model)
        //            case .failure(let error):
        //                Log.d(error)
        //            }
        //        })
        
        // MARK: TranslationAPITestCode
        //        TranslationAPI.requestTraslation(request: TranslationDTO(text: "안녕하세요", source: Papago.Code.ko.rawValue, target: Papago.Code.en.rawValue), completion: { (result) in
        //            switch result {
        //            case .success(let model):
        //                Log.d(model)
        //            case .failure(let error):
        //                Log.e(error)
        //            }
        //        })
        
        // MARK: VideoSubtitle
        //        VideoSubtitleAPI.requestVideoSubtitle(request: VideoSubtitleDTO(media: urlrrl, params: VideoReqInfo())) { (result) in
        //            switch result {
        //            case .success(let model):
        //                Log.d(model)
        //            case .failure(let error):
        //                Log.e(error)
        //            }
        //        }
        
        // MARK: RealmTestCode
        let repo = BookmarkRepository(storage: BookmarkStorage())
        //        repo.fetchBookmarkList(query: .month("2022.11"), page: 0, completion: {
        //            Log.d($0)
        //        })
        //
        //        repo.fetchBookmarkList(query: .all, page: 1, completion: { bookmarkList in
        //            Log.d(bookmarkList)
        //        })
        
        //        repo.updateBookmark(bookmark: Bookmark(id: 12,
        //                                               mood: Mood(mood: .angry),
        //                                               weather: Weather(weather: .atmosphere),
        //                                               date: "0000.00.00",
        //                                               location: Location(lat: 36.003, lon: 127.214, address: "집"),
        //                                               hasWritten: false,
        //                                               note: "업데이트 테스트"), completion: {
        //            switch $0 {
        //            case .success(let model):
        //                Log.d(model)
        //            case .failure(let error):
        //                Log.e(error)
        //            }
        //        })
        //
//        let bookmark1 = Bookmark(id: 0,
//                                 mood: Mood(mood: .angry),
//                                 weather: Weather(weather: .atmosphere),
//                                 date: "2029.11.3",
//                                 location: Location(lat: 30.000, lon: 120.000, address: "집"),
//                                 hasWritten: false,
//                                 note: "이거는 메모입니다")
//
//        let bookmark2 = Bookmark(id: 0,
//                                 mood: Mood(mood: .amazed),
//                                 weather: Weather(weather: .drizzle),
//                                 date: "2021.10.2",
//                                 location: Location(lat: 36.003, lon: 127.214, address: "집"),
//                                 hasWritten: false,
//                                 note: "이거는 메모입니다")
//
//        let bookmark3 = Bookmark(id: 0,
//                                 mood: Mood(mood: .sad),
//                                 weather: Weather(weather: .clouds),
//                                 date: "2002.10.2",
//                                 location: Location(lat: 36.003, lon: 127.214, address: "집"),
//                                 hasWritten: false,
//                                 note: "이거는 메모입니다")
//
//        let bookmark4 = Bookmark(id: 0,
//                                 mood: Mood(mood: .angry),
//                                 weather: Weather(weather: .clear),
//                                 date: "2088.09.2",
//                                 location: Location(lat: 46.003, lon: 227.214, address: "집"),
//                                 hasWritten: false,
//                                 note: "이거는 메모입니다")
//
//        [bookmark1, bookmark2, bookmark3, bookmark4].forEach {
//            repo.addBookmark(bookmark: $0, completion: {
//                Log.d("Insert Success:: \($0)")
//            })
//        }
        let min = CLLocationCoordinate2D(latitude: 36.000, longitude: 127.000)
        let max = CLLocationCoordinate2D(latitude: 40.000, longitude: 130.000)
        repo.fetchBookmarkList(query: .location(min, max), page: 5, completion: { bookmarkList in
            bookmarkList.bookmarks.forEach {
                Log.d($0.location)
                print()
            }
        })
    }
}
