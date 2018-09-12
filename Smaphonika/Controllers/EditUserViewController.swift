//
//  EditUserViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/07/18.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class EditUserViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var introductionTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true

        userNameTextField.delegate = self
        userIdTextField.delegate = self
        introductionTextView.delegate = self
        
        let userId = NCMBUser.current().userName
        userIdTextField.text = userId
        
        if let user = NCMBUser.current() {
            userNameTextField.text = user.object(forKey: "displayName") as? String
            userIdTextField.text = user.userName
            introductionTextView.text = user.object(forKey: "introduction") as? String
            
            
            let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: nil) as! NCMBFile
            file.getDataInBackground { (data, error) in
                if error != nil {
                    let alert = UIAlertController(title: "画像取得エラー", message: error!.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                    })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.userImageView.image = image
                    }
                }
            }
        } else {
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            // ログイン状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let resizedImage = selectedImage.scale(byFactor: 0.3)
        
        
        
        picker.dismiss(animated: true, completion: nil)
        
        let data = UIImagePNGRepresentation(resizedImage!)
        let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: data) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil {
                let alert = UIAlertController(title: "画像アップロードエラー", message: error!.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
    }
    
    @IBAction func selectImage () {
        let actionController = UIAlertController(title: "画像の選択", message: "選択してください。", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            //カメラ起動のコード
            let piker = UIImagePickerController()
            piker.sourceType = .camera
            piker.allowsEditing = true
            piker.delegate = self
            self.present(piker, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            //ライブラリ起動のコード
            let piker = UIImagePickerController()
            piker.sourceType = .photoLibrary
            piker.allowsEditing = true
            piker.delegate = self
            self.present(piker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionController.dismiss(animated: true, completion: nil)
        }
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        self.present(actionController, animated: true, completion: nil)
        
    }
    
    @IBAction func closeEditviewController () {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveUserInfo () {
        if let user = NCMBUser.current() {
            user.setObject(userNameTextField.text, forKey: "displayName")
            user.setObject(userIdTextField.text, forKey: "userName")
            user.setObject(introductionTextView.text, forKey: "introduction")
           // user.setObject(userImageView, forKey: "userImage")
            user.saveInBackground({ (error) in
                if error != nil {
                    let alert = UIAlertController(title: "送信エラー", message: error!.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                })
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    })
        }
    }
    
    
}
