import UIKit
import WebKit

// https://developer.apple.com/documentation/webkit/wkwebview
class TrainingViewController: UIViewController, WKUIDelegate {
    let trainingUrl = Helpers.loadAppSetting(byKey: Constants.helpAndTrainingUrl)
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: trainingUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
