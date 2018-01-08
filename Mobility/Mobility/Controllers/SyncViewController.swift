import UIKit

class SyncViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Actions
    @IBAction func syncButton(_ sender: UIButton) {
        SessionService.sync(success: {() -> Void in
            // placeholder/demo for spike/research card, do nothing yet
        }, failure: {(error: HTTPError) -> Void in
            // placeholder/demo for spike/research card, do nothing yet
            Helpers.showErrorToast(view: self.view, message: error.message)
        }) 
    }
}
