//
//  HomeVC.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 08/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HomeVC: UIViewController , UITextFieldDelegate {
    
    var userName: NSString = "";
    
    @IBOutlet weak var lblMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblMessage.text = "Welcome \(userName)!"
    
        navigationController?.navigationBar.isHidden = false;
    }
    
    func listUsers(_ accessToken: String){
        Spinner.start(from: self.view)
        ApiService<Response<[User]>>().get("users").token(accessToken).call { response in
            Spinner.stop()
            
            if let responseData = response.result.value {
                if(responseData.data != nil){
                    
                }else{
                   // self.showError(responseData.error?.message ?? "Something went wrong!")
                }
                
            }else {
               // self.showError("Something went wrong!")
            }
        }
    }
    
   
   
}
