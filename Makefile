project:
	tuist clean
	tuist fetch
	tuist generate --no-open && pod install &&  open Diary.xcworkspace
	

asset:
	tuist generate
	pod install
