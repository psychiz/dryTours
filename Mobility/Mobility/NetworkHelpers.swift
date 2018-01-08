import Alamofire
import SwiftyJSON

class NetworkHelpers {
    static func transformMaximoServerError(response: DataResponse<Any>) -> NSError {
        let json = JSON(response.data!)
        let statusCode = response.response?.statusCode ?? 0
        let message = json["Error"]["message"].string ?? "There was a problem with the request."
        let error = NSError(domain: "Server", code: statusCode, userInfo: ["message": "\(statusCode) \(message)"])
        
        return error
    }
}

enum VoidResult {
    case success(Any?)
    case failure(NSError)
}

// https://stackoverflow.com/questions/29365145/how-to-encode-string-to-base64-in-swift
extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
