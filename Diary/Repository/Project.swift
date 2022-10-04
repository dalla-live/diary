import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: Module.repository.name,
                                dependencies: [.moya, .swiftyJson] + [Module.util.project, Module.domain.project],
                                resources: .default
)
