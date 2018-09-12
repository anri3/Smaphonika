//
//  SighInViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/07/14.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import NCMB

class SighInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var passwardTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate = self
        passwardTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    @IBAction func sighIn () {
        if (userIdTextField.text?.count)! > 0 && (passwardTextField.text?.count)! > 0{
        
        
        NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwardTextField.text!) { (user, error) in
            if error != nil {
                print("error")
            } else {
                // ログイン成功
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                //ログイン状態の保持
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
            }
        }
    }
    }
        
        
    @IBAction func forgetPassward () {
        //置いておく
    }
    
}

