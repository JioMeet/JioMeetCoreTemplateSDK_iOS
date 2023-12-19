source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'

target 'JioMeetCoreUIDemo' do
	# Comment the next line if you don't want to use dynamic frameworks
	use_frameworks!
	pod 'JioMeetUIKit_iOS', '~>3.0.2'
	
	# Comment the next line if you don't want to use Participant Panel
	pod 'JioMeetParticipantPanelSDK_iOS', '~>3.0.2'
	
	# Comment the next line if you dont' want to use Chat Functionality
	pod 'JioMeetChatUIKit_iOS', '~>3.0.2'
	
	# Comment the next line if you don't want to use Virtual Background Feature
	pod 'JioMeetVBGUIKit_iOS', '~>3.0.2'
  
        # Comment the next line if you don't want to use Reactions Feature
  	pod 'JioMeetReactions_iOS', '~>3.0.2'

end

target 'ScreenShareExtension' do
	use_frameworks!
	pod 'JioMeetScreenShareSDK_iOS', '~>3.0.2'
end

post_install do |installer|
  xcode_base_version = `xcodebuild -version | grep 'Xcode' | awk '{print $2}' | cut -d . -f 1`
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
      # For xcode 15+ only
      if config.base_configuration_reference && Integer(xcode_base_version) >= 15
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    end
  end
end
