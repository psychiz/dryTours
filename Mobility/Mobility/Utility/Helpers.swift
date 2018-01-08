import Toast_Swift

import Foundation
import os.log

class Helpers {
    static func loadAppSetting(byKey key: String) -> String {
        let version = Bundle.main.infoDictionary?[key] as? String
        
        return version!
    }
    
    static func loadEnvironmentVariable(byKey key: String) -> String {
        let environmentVariables = ProcessInfo.processInfo.environment
        let env = environmentVariables[key] ?? ""
        
        return env
    }
    
    static func showErrorToast(view: UIView, message: String) {
        var style = ToastStyle()
    
        style.backgroundColor = .red
        
        view.makeToast(message, duration: 10.0, position: .top, style: style)
    }
}

struct Platform {
    // https://stackoverflow.com/a/30284266/1747442
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}
