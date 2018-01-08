import Foundation
import Alamofire
import SwiftyJSON
import CoreData

// http://ashishkakkad.com/2016/03/how-to-create-a-wrapper-for-alamofire-and-swiftyjson-swift-ios/
// Note: Need to call .validate() on any Alamofire request to ensure isFailure is called successfully
// <https://github.com/Alamofire/Alamofire/issues/847>
// Handling error codes:
// <https://stackoverflow.com/questions/29131253/swift-alamofire-how-to-get-the-http-response-status-code>

public class SessionService
{
    public static let defaultSession = URLSession(configuration: .default)  // cookies/headers

    static var dataSource: String = Constants.defaultDataSource
    // TODO: this should be improved once we figure out webMethods/Airwatch, handle appropriately for release builds.
    // TODO: data source should be persisted in database for app close, reloads
    static var endpoint: String {
        var host: String
        var path: String
        
        if dataSource.lowercased().contains("local") {
            host = Constants.localConnectionUrl
        } else {
            host = Constants.remoteConnectionUrl
        }
        
        if dataSource.lowercased().contains("mocked") {
            path = "mocked"
        } else if dataSource.lowercased().contains("sandbox") {
            path = "/maximo/sandbox"
        } else {
            path = "/maximo/dev"
        }
        
        var parsedUrl = URL(string: host)
        parsedUrl?.appendPathComponent(path)
        
        return parsedUrl?.absoluteString ?? "bad url set"
    }

    static func login(username: String, password: String,
                      success:@escaping () -> Void, failure:@escaping (HTTPError) -> Void)
    {
    
        let combinedCredentials: String = "\(username):\(password)"
        let base64Credentials = combinedCredentials.toBase64()
        let headers: HTTPHeaders = [
            "maxauth": base64Credentials,
            "Accept": "application/json"
        ]
        let endpoint = "\(SessionService.endpoint)/login"

        Alamofire.request(endpoint, method: .post, headers: headers).validate().responseJSON { response in
            if response.result.isSuccess {
                success()
            }
            if response.result.isFailure {
                let json = JSON(response.data!)
                let message = json["Error"]["message"].string ?? ""
                let statusCode = response.response?.statusCode ?? 0

                let error = HTTPError(message: message, statusCode: statusCode)

                failure(error)
            }
        }
    }

    static func whoami(completion: @escaping (_ result: VoidResult) -> Void) {
        let endpoint = "\(SessionService.endpoint)/whoami"

        Alamofire.request(endpoint).validate().responseJSON { response in
            if response.result.isSuccess {
                completion(.success(response.result.value))
            } else if response.error != nil {
                let maximoError = NetworkHelpers.transformMaximoServerError(response: response)
                completion(.failure(maximoError))
            } else {
                fatalError("No error, no failure")
            }
        }
    }

    static func sync(success:@escaping () -> Void, failure:@escaping (HTTPError) -> Void) {
        // note: hard coded intentially for demo purposes. Implement once cards committed to.
        let host = Platform.isSimulator ? Constants.localConnectionUrl : Constants.remoteConnectionUrl
        let endpoint = "\(host)/mocked/sync"
        // let endpoint = "http://csgcollt230.local:8080/mocked/sync"

        Alamofire.request(endpoint).responseJSON { response in
            if response.result.isSuccess {
                success()
            } else if response.error != nil {
                let error = HTTPError(message: "Bad", statusCode: 200)
                failure(error)
            }
        }
    }
}
