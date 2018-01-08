//
//  Utility.swift
//  Mobility
//
//  Created by zeeshan on 01/01/18.
//  Copyright © 2018 zeeshan. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func isInternetConnectionAvailable() ->Bool
    {
        
        let networkReachability = Reachability.forInternetConnection()
        let networkStatus  = networkReachability?.currentReachabilityStatus()
        
        if networkStatus == NotReachable
        {
            
            print("Not reachable")
            return false
        }
        else
        {
            
            return true
        }
    }
    
    
    class func alertController(message : String)
    {
        var viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Error: Retry")
        }
        alertController.addAction(OKAction)
        viewController?.present(alertController, animated: true, completion: nil)
        print ("retry")
        
    }
    
    
}
