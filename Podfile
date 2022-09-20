# Uncomment the next line to define a global platform for your project

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!


workspace 'Diary'
project 'Diary/App.xcodeproj'
project 'Diary/Domain.xcodeproj'
project 'Diary/Design.xcodeproj'
project 'Diary/Presantation.xcodeproj'
project 'Diary/Repository.xcodeproj'
project 'Diary/Service.xcodeproj'
project 'Diary/Util.xcodeproj'



def pods
  pod 'RealmSwift'
end

target 'App' do
  project 'Diary/App/App.xcodeproj'
  pod 'GoogleMaps'
  pods

end

target 'Domain' do
  project 'Diary/Domain/Domain.xcodeproj'

  pods

end

target 'Design' do
  project 'Diary/Design/Design.xcodeproj'

  pods

end

target 'Presantation' do
  project 'Diary/Presantation/Presantation.xcodeproj'
  
  pods

end

target 'Repository' do
  project 'Diary/Repository/Repository.xcodeproj'

  pods

end

target 'Service' do
  project 'Diary/Service/Service.xcodeproj'
  pods
  pod 'GoogleMaps'
  pod 'Google-Maps-iOS-Utils'

end

target 'Util' do
  project 'Diary/Util/Util.xcodeproj'
  pods

end
