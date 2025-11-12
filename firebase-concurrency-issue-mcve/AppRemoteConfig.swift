import FirebaseRemoteConfig

class AppRemoteConfig {
  static let shared = AppRemoteConfig()
  
  private lazy var remoteConfig: RemoteConfig = {
    let config = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    settings.minimumFetchInterval = 0
    config.configSettings = settings
    config.setDefaults(fromPlist: "remote_config_defaults")
    return config
  }()
  
  func fetch() {
    remoteConfig.fetch { [remoteConfig] status, error in
      guard error == nil else { return }
      
      let exampleFlagValue = remoteConfig.configValue(forKey: "example")
      print("Example remote config value: \(exampleFlagValue.boolValue)")
    }
  }
}
