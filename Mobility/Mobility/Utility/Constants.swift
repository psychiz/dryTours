enum Constants {
    static let localConnectionUrl = Helpers.loadAppSetting(byKey: "AEPConnectionStringLocalHost")
    static let remoteConnectionUrl = Helpers.loadAppSetting(byKey: "AEPConnectionStringRemoteHost")
    static let defaultUsername = "AEPMobilityUsername"  // potential local development environment variable
    static let defaultPassword = "AEPMobilityPassword"  // potential local development environment variable
    static let helpAndTrainingUrl = "AEPHelpAndTrainingUrl"
    static let releaseVersionKey = "CFBundleShortVersionString"
    static let buildVersionKey = "CFBundleVersion"

    // TODO: selecting data source this should be improved once we figure out webMethods/Airwatch
    static let dataSources = [
        "Local Mocked",
        "Remote Mocked",
        "Local Maximo Sandbox",
        "Remote Maximo Sandbox",
        "Local Maximo Dev",
        "Remote Maximo Dev",
        "Local Maximo Test",
        "Remote Maximo Test"
    ]
    
    static let defaultDataSource = dataSources[0]
}
