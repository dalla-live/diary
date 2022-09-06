import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "Diary",
                          projects: Module.allCases.map(\.path))
