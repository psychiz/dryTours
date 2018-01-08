


//

import UIKit

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
     picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        dismiss(animated:true, completion: nil) //5
    }
}
