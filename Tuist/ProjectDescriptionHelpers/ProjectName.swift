//
//  ProjectName.swift
//  ProjectDescriptionHelpers
//
//  Created by cheonsong on 2022/09/02.
//

import ProjectDescription

public enum Module {
    case app
    // Repository|DataStore
    case repository
    
    // Presantation
    case presantation
    
    // Domain
    case domain
    
    // Design|UI
    case design
    
    case util
    case service
}

extension Module {
    public var name: String {
        switch self {
        case .app:
            return "App"
        case .repository:
            return "Repository"
        case .presantation:
            return "Presantation"
        case .domain:
            return "Domain"
        case .design:
            return "Design"
        case .util:
            return "Util"
        case .service:
            return "Service"
        }
    }
    
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Diary/" + self.name)
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}

extension Module: CaseIterable { }
