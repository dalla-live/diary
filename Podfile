# Uncomment the next line to define a global platform for your project

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!


workspace 'Diary.xcworkspace'
project 'Diary/App/App.xcodeproj'
project 'Diary/Domain/Domain.xcodeproj'
project 'Diary/Design/Design.xcodeproj'
project 'Diary/Presantation/Presantation.xcodeproj'
project 'Diary/Repository/Repository.xcodeproj'
project 'Diary/Service/Service.xcodeproj'
project 'Diary/Util/Util.xcodeproj'



def pods
  pod 'RealmSwift'
end

target 'App' do
  project 'Diary/App/App.xcodeproj'
#  pod 'GoogleMaps'
  pod 'NMapsMap'
  pods

end

target 'Domain' do
  project 'Diary/Domain/Domain.xcodeproj'

  pods
#  pod "GooglePlaces", '7.1.0'
end

target 'Design' do
  project 'Diary/Design/Design.xcodeproj'

  pods

end

target 'Presantation' do
  project 'Diary/Presantation/Presantation.xcodeproj'
  pod 'NMapsMap'
  pod 'GoogleMaps'
  pod 'Google-Maps-iOS-Utils'
  pod "GooglePlaces", '7.1.0'
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
  pod "GooglePlaces", '7.1.0'
  pod 'NMapsMap'
end

target 'Util' do
  project 'Diary/Util/Util.xcodeproj'
  pods

end
