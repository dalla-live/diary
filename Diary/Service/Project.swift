import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: Module.service.name,
                                dependencies: [Module.util.project]
)
