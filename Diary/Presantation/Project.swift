import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: Module.presantation.name,
                                dependencies: [.rxSwift, .rxCocoa] + [Module.util.project, Module.domain.project],
                                resources: .default
)
