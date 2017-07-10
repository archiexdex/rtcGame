//
//  LoginViewController.swift
//  rtcGame
//
//  Created by HsinChih Yang on 09/07/2017.
//  Copyright © 2017 Archie. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet var faceBookLogInButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceBookLogInButton.readPermissions = ["public_profile", "email", "user_friends"]
        faceBookLogInButton.delegate = self
        
        if FBSDKAccessToken.current() != nil {
            fetchProfile()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func fetchProfile() {
        
        print(">> fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("longinerror =\(error)")
            }
            else {
                
                if let resultNew = result as? [String:Any]{
                    
                    let email = resultNew["email"] as! String
                    print("email : ", email)
                    
                    let firstName = resultNew["first_name"] as! String
                    print("firstName : ", firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print("lastName : ", lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print("url : ", url)
                    }
                }
            }
        })
    }

}

extension LoginViewController: FBSDKLoginButtonDelegate {
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //
    }

    /**
     Sent to the delegate when the button was used to login.
     - Parameter loginButton: the sender
     - Parameter result: The results of the login
     - Parameter error: The error (if any) from the login
     */
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        fetchProfile()
        
        if (error == nil)  {
            print("log in successful")
        }
        
        DispatchQueue.global().async {
            DispatchQueue.main.async(execute: {
                self.dismiss(animated: true) {
                    //
                    print("go back")
                }
            })
        }
        
    }

    
}
