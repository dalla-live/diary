//
//  Coordinator.swift
//  Util
//
//  Created by inforex_imac on 2022/09/14.
//

import Foundation

public protocol Coordinator {
    var childCoordinator : [Coordinator] { get set }
    func start()
}
