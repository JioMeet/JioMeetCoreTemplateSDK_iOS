source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'

target 'JioMeetCoreUIDemo' do
	# Comment the next line if you don't want to use dynamic frameworks
	use_frameworks!
	pod 'JioMeetUIKit_iOS', '~> 2.0'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
		end
	end
end