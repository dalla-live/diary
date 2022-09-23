import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: Module.design.name,
                                dependencies: [Module.util.project],
                                resources: .default
)
