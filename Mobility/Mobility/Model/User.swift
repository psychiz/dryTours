import Foundation

class User: Codable {
    let username: String
    let displayName: String
    
    init(username: String, displayName: String) {
        self.username = username
        self.displayName = displayName
    
    }
    
    init?(json: [String: Any]) {
        guard let username = json["userName"] as? String,
            let displayName = json["displayName"] as? String
        else {
            return nil
        }
            
        self.username = username
        self.displayName = displayName
    }
}
