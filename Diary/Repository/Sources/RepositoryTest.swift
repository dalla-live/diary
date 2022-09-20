//
//  RepositoryTest.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Util
import RealmSwift

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
        
        // MARK: RealmTestCode
//        let bmManager = DBManager<BM>()
//        bmManager.add(BM(id: 1, weather: "맑음", location: Coord(), mood: "행복", hasWritten: false))
//        bmManager.add(BM(id: 2, weather: "흐림", location: Coord(), mood: "우울", hasWritten: false))
//        bmManager.add(BM(id: 3, weather: "비", location: Coord(), mood: "피곤", hasWritten: false))
//
//        let diaryManager = DBManager<Diary>()
//        let bookmarks = bmManager.read()
//        let object = bookmarks.filter("id == 2")
//
//        diaryManager.add(Diary(id: 1, contents: "일기입니다~", bookmark: object.first!))
//
//        let realm = try! Realm()
//        let objects = realm.objects(BM.self)
//
//        let bm = objects.filter("id == 2").first!
//
//        try! realm.write {
//            bm.weather = "천둥"
//        }
//
//        Log.d(bmManager.read())
//        Log.d(diaryManager.read())
    }
}
