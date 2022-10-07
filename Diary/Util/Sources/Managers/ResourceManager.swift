//
//  ResourceManager.swift
//  Util
//
//  Created by chuchu on 2022/09/26.
//

import Foundation
import UIKit

public struct ResourceManager {
    public static let shared = ResourceManager()
    
    private let filePath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appendingPathComponent("Resource")
    
    public func makeResourceDirectory() {
        if !FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.createDirectory(atPath: filePath.path, withIntermediateDirectories: true)
            } catch {
                Log.e("do not create Directory")
            }
        }
    }
    
    /// Save image file in local.
    /// - Parameters:
    ///   - imageNo: `imageNo` is the last line number +1 in the database.
    ///   - view: Take a snapshot with `view`.
    ///   - compressionQuality: Image `compressionQuality` percentage, default value is 0.5.
    public func saveImage(imageNo: String, from view: UIView, _ compressionQuality: CGFloat = 0.5) {
        let imageData = view.layer.snapshotImage?.jpegData(compressionQuality: compressionQuality)
        do {
            try imageData?.write(to: filePath.appendingPathComponent(imageNo))
        } catch let error {
            print(error.localizedDescription)
            Log.e("do not save image")
        }
    }
    
    public func getImage(imageNo: String) -> UIImage? {
        return UIImage(contentsOfFile: URL(fileURLWithPath: filePath.absoluteString).appendingPathComponent(imageNo).path)
        
    }
    
    public func writeJson(jsonDic: [String: String]) {
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted) {
            let pathWithFileName = filePath.appendingPathComponent("jsonData")
            do {
                try jsonData.write(to: pathWithFileName)
            } catch {
                Log.e("do not write json")
            }
        }
    }
    
    public func getJson() -> [String: String] {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath.absoluteString).appendingPathComponent("jsonData"), options: .mappedIfSafe),
              let model = try? JSONDecoder().decode([String :String].self, from: data) else {
            return [:]
        }
        return model
    }
    
    public func readJson(key: Int, completion: ((Result<String, Error>) -> Void)? = nil) {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath.absoluteString).appendingPathComponent("jsonData"), options: .mappedIfSafe),
           let model = try? JSONDecoder().decode([String :String].self, from: data),
           let value = model[String(key)] {
            
            completion?(.success(value))
        } else {
            completion?(.failure(ResourceError.unknowned))
        }
    }
}

extension ResourceManager {
    enum ResourceError: Error {
        case unknowned
        case canNotFindFile
    }
}
