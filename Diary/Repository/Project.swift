import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: Module.repository.name,
                                dependencies: [.moya, .swiftyJson, .realm] + [Module.util.project]
)
