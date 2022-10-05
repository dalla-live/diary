//
//  DiaryTabbarController.swift
//  Design
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit

public enum TabMenu: Int {
    case bookMark = 0, map = 1, diary = 2, video = 3
    public var title : String {
        switch self {
        case .bookMark:
            return ""
        case .map:
            return ""
        case .diary :
            return ""
        case .video :
            return ""
        }
    }
}

public class DiaryTabbarController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        self.tabBar.backgroundColor = .gray
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.tintColor = .blue
        
    }
    
    public override func viewWillLayoutSubviews() {
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DiaryTabbarController: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selected = TabMenu(rawValue: tabBarController.selectedIndex)
        
        print("Should select viewController: \(tabBarController.selectedIndex) \(selected?.title ?? "none")")
           return true
       }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selected = TabMenu(rawValue: tabBarController.selectedIndex)
        print("did select viewController: \(tabBarController.selectedIndex) \(selected?.title ?? "none")")
    }
}
