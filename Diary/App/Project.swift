import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(name: Module.app.name, dependencies: [
    Module.domain,
    Module.repository,
    Module.presantation,
    Module.design,
    Module.util,
    Module.service
].map(\.project))
