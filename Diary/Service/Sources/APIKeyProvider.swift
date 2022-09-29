//
//  APIKeyProvider.swift
//  Service
//
//  Created by cheonsong on 2022/09/29.
//

import Foundation
import GoogleMaps
import GoogleMapsUtils
import GooglePlaces

public class APIKeyProvider {
    public static let shared = APIKeyProvider()
    
    private init() {

    }
    
    public func add() {
        GMSPlacesClient.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
        GMSServices.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
    }
}
