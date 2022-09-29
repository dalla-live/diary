import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: Module.util.name,
                                dependencies: [.snapKit, .then, .rxSwift, .rxCocoa, .rxGesture, .toast])
