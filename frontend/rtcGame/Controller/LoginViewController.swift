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

    
    @IBOutlet var thePetName: UITextField!
    @IBOutlet var thePetType: UITextField!
    @IBOutlet var thePetGender: UISegmentedControl!
    
    @IBOutlet var faceBookLogInButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thePetName.delegate = self
        thePetType.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
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
    

    @IBAction func dd(_ sender: Any) {
        
        let data : [String:AnyObject] = ["name":"QQ" as AnyObject, "age":22 as AnyObject]
        HTTPClient().httpRequest(type: Constants.api.serviceType.getPost.rawValue, parameters: data) { (message, parameter) in
            print(">>message ", message)
            print(">>parameter ",parameter)
        }
        
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
                    UserDefaults.standard.setValue(email, forKey: "EMAIL")
                    
                    let firstName = resultNew["first_name"] as! String
                    print("firstName : ", firstName)
                    
                    let lastName = resultNew["last_name"] as! String
                    print("lastName : ", lastName)
                    
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print("url : ", url)
                        UserDefaults.standard.setValue(url, forKey: "URL")
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
        
        let name = self.thePetName.text
        let type = self.thePetType.text
        let gender = self.thePetGender.selectedSegmentIndex
        
        UserDefaults.standard.setValue(name, forKey: "NAME")
        UserDefaults.standard.setValue(type, forKey: "TYPE")
        UserDefaults.standard.setValue(gender, forKey: "GENDER")
        
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

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewMove(isUp: true, value: 100)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewMove(isUp: false, value: 100)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func viewMove(isUp: Bool, value: CGFloat) {
        
        let move : CGFloat = isUp ? -value : value
        UIView.beginAnimations("animationView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(0.3)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: move)
        UIView.commitAnimations()
        
    }
}
