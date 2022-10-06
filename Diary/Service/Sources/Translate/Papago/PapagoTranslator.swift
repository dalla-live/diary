//
//  PapagoTranslator.swift
//  Service
//
//  Created by cheonsong on 2022/10/06.
//

import Foundation

class PapagoTranslator: Translatable {
    var source: LaguageCode = .ko
    
    var target: LaguageCode = .en
    
    func set(source: LaguageCode, target: LaguageCode) {
        self.source = source
        self.target = target
    }
    
    func translate(text: String, _ completion: @escaping ((String)-> Void)) {
        
        translate(source: text) {
            completion($0)
        }
    }
    
    
    // ================================================
    public static let shared = PapagoTranslator()
    
    static let naverClientID = "3lbxmOH9ULv_yXxcd7Ix"
    static let naverClientSecret = "iEmQSS23O4"
    
    var session: URLSession!
    
    private init() {
        setUp()
    }
    
    func setUp() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    func translate(source: String, completion: @escaping (String)-> Void) {
        var url = URLComponents(string: "https://openapi.naver.com/v1/papago/n2mt?")
        
        let sourceQuery = URLQueryItem(name: "source", value: self.source.papago)
        let targetQuery = URLQueryItem(name: "target", value: self.target.papago)
        let textQuery = URLQueryItem(name: "text", value: source)
        
        url?.queryItems?.append(sourceQuery)
        url?.queryItems?.append(targetQuery)
        url?.queryItems?.append(textQuery)
        
        let requestURL = url?.url
        
        var request = URLRequest(url: requestURL!)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue(PapagoTranslator.naverClientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(PapagoTranslator.naverClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        request.addValue("\(source.count)", forHTTPHeaderField: "Content-length")
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard let resultData = data else {
                completion("Error")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: resultData, options: []) as? [String : Any] {
                if let message = json["message"] as? [String : Any],
                   let result = message["result"] as? [String: Any],
                   let translatedText = result["translatedText"] as? String{
                    completion(translatedText)
                }
            }
        }
        
        dataTask.resume()
    }
    
}
