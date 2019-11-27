//
//  ViewController.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 07/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnProceed: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        btnProceed.layer.cornerRadius = 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }

    @IBAction func onProceed(_ sender: UIButton) {
        
        tfUsername.resignFirstResponder()
        tfPassword.resignFirstResponder()
        
        lblMessage.layer.cornerRadius = 20
        
        let username: String = tfUsername.text!;
        let password: String = tfPassword.text!;
        
        if(username == ""){
            showError("Please enter username!");
           
        }else if(password == ""){
           showError("Please enter password!");
            
        }else{
           
            lblMessage.isHidden = true;
            login2(username: username, password: password)
        }
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         navigationController?.navigationBar.isHidden = true;
    }
    
    
    func showError(_ msg:String){
        lblMessage.backgroundColor = UIColor.red;
        lblMessage.text = msg;
        lblMessage.isHidden = false;
    }
    
    func showSuccess(_ msg:String){
        lblMessage.backgroundColor = UIColor.green;
        lblMessage.text = msg;
        lblMessage.isHidden = false;
    }
    
     func login2(username: String, password: String){
        
         Spinner.start(from: self.view)
        
        let params : [String: Any] = ["username": username, "password": password, "deviceId": "123", "grant_type": "password"];
        ApiService<Response<AccessToken>>().post("oauth/token", parameters: params).authenticate().call { response in
          
            Spinner.stop()
            
             if let responseData = response.result.value {

                if(responseData.data != nil){
                   
                    self.showSuccess("Welcome \(responseData.data?.user ?? "")!")
                    
                    let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC;
                    mainViewController.userName = responseData.data?.user as! NSString;
                   // self.present(mainViewController, animated: true, completion: nil);
                    self.navigationController?.pushViewController(mainViewController, animated: true);
                       
                    
                }else{
                     self.showError(responseData.error?.message ?? "Something went wrong!")
                }
                
             }else {
                self.showError("Something went wrong!")
            }
        }
    }
    
    
   
   
}

