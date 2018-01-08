import Foundation

class HTTPError: Codable {
    let message: String
    let statusCode: Int
    
    init(message: String, statusCode: Int) {
        self.message = message
        self.statusCode = statusCode
    }
    
}
