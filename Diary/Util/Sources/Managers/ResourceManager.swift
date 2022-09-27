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
    
    let filePath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0].appendingPathComponent("Resource")
    
    public func makeResourceDirectory() {
        if !FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.createDirectory(atPath: filePath.path, withIntermediateDirectories: true)
            } catch {
                Log.e("do not create Directory")
            }
        }
    }
    
    public func saveImage(imageNo: String, imageData: Data) {
        do {
            try imageData.write(to: filePath.appendingPathComponent(imageNo))
        } catch let error {
            print(error.localizedDescription)
            Log.e("do not save image")
        }
    }
    
    public func getImage(imageNo: String) -> UIImage? {
        return UIImage(contentsOfFile: URL(fileURLWithPath: filePath.absoluteString).appendingPathComponent(imageNo).path)
    }
    
    public func test() {
        print("hi")
    }
    
}
