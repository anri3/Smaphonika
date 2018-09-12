//
//  SighUpViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/07/13.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class SighUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwardTextfield: UITextField!
    @IBOutlet var confirmTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate = self
        emailTextField.delegate = self
        passwardTextfield.delegate = self
        confirmTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func sighUp () {
        let user = NCMBUser()
        
        if (userIdTextField.text?.count)! < 4 {
            print("文字数が足りません")
            return
        }
        
        user.userName = userIdTextField.text!
        user.mailAddress = emailTextField.text!
        
        if passwardTextfield.text == confirmTextField.text {
            user.password = passwardTextfield.text!
        } else {
            print("パスワードの不一致")
        }
        
        user.signUpInBackground { (error) in
            if error != nil {
                //エラーがあった場合
                print("error1")
            } else {
                //登録成功
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
                
                let ud = UserDefaults.standard
                ud.set(true, forKey: "isLogin")
                ud.synchronize()
            }
        }
        
    }
   
}
