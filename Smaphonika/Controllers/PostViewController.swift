//
//  PostViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/02.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit
import UITextView_Placeholder
import SVProgressHUD
import Kingfisher

class PostViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {
    
    let placeholderImage = UIImage(named: "photo-placeholder")
    
    var resizedImage: UIImage!
    
    var weatherlabel = UILabel()
    
    var weatherImages = ["hare.png","kumorihare.png","kumori.png","ame.png","yuki.png"]
    
    @IBOutlet var postImageView: UIImageView!
    
    @IBOutlet var photoSelectedButton: UIButton!
    
    @IBOutlet var paintButton: UIButton!
    
    @IBOutlet var titleTextView: UITextView!
    
    @IBOutlet var monthTextField: UITextField!
    
    @IBOutlet var dayTextField: UITextField!
    
    //@IBOutlet var weatherButton: UIButton!
    
    //PickerViewの紐付け
    @IBOutlet weak var weatherPickerView: UIPickerView!
    
    //@IBOutlet var weatherImageView: UIImageView!
    
    @IBOutlet var postTextView: UITextView!
    
    @IBOutlet var postButton: UIBarButtonItem!
    
    @IBOutlet var postSaveButton: UIBarButtonItem!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var monthLabel: UILabel!
    
    @IBOutlet var dayLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var topView: UIView!
    
    @IBOutlet var centerView: UIView!
    
    @IBOutlet var underView: UIView!
    
    @IBOutlet var leftView: UIView!
    
    @IBOutlet var rightView: UIView!
    
    @IBOutlet var verticalView: UIView!
    
    @IBOutlet var sideView: UIView!
    
 
    // Screenの高さ
    var screenHeight:CGFloat!
    // Screenの幅
    var screenWidth:CGFloat!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()

        postImageView.image = placeholderImage
        
        postButton.isEnabled = false
        postTextView.placeholder = "内容を書く"
        postTextView.delegate = self
        
        titleTextView.placeholder = "題を書く"
        titleTextView.delegate = self
        
        monthTextField.delegate = self
        dayTextField.delegate = self
        
        // Delegate設定
        weatherPickerView.delegate = self
        weatherPickerView.dataSource = self
        
       scrollView.delegate = self
        
        // 画面サイズ取得
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        print("screenWidth:\(screenWidth)")
        print("screenHeight:\(screenHeight)")
        
        // 表示窓のサイズと位置を設定
        scrollView.frame.size =
            CGSize(width: screenWidth, height: screenHeight)
        
        // UIScrollViewに追加
        scrollView.addSubview(postImageView)
        scrollView.addSubview(photoSelectedButton)
        scrollView.addSubview(paintButton)
        scrollView.addSubview(titleTextView)
        scrollView.addSubview(monthTextField)
        scrollView.addSubview(dayTextField)
        scrollView.addSubview(weatherPickerView)
        scrollView.addSubview(postTextView)
        scrollView.addSubview(monthLabel)
        scrollView.addSubview(dayLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(topView)
        scrollView.addSubview(centerView)
        scrollView.addSubview(underView)
        scrollView.addSubview(leftView)
        scrollView.addSubview(rightView)
        scrollView.addSubview(verticalView)
        scrollView.addSubview(sideView)
        
        // UIScrollViewの大きさを画像サイズに設定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight*1.2)
        
        // スクロールの跳ね返り無し
        scrollView.bounces = false
        
        // ビューに追加
        self.view.addSubview(scrollView)
        
        //postImageView.image = resizedImage
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PostViewController.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PostViewController.keyboardWillHide(_:)) ,
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillShow,
                                                  object: self.view.window)
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardDidHide,
                                                  object: self.view.window)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        let info = notification.userInfo!
        
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // bottom of textField
        let bottomTextField = postTextView.frame.origin.y + postTextView.frame.height
        // top of keyboard
        let topKeyboard = screenHeight - keyboardFrame.size.height
        // 重なり
        let distance = bottomTextField - topKeyboard
        
        if distance >= 0 {
            // scrollViewのコンテツを上へオフセット + 20.0(追加のオフセット)
            scrollView.contentOffset.y = distance + 20.0
        }
        
       
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset.y = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
      
        confirmContent()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        resizedImage = selectedImage.scale(byFactor: 0.4)
        
        postImageView.image = resizedImage
        
        picker.dismiss(animated: true, completion: nil)
        
        confirmContent()
    }
    
  
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        
        var weatherImageView = UIImageView()
        
        switch row {
        case 0:
            weatherImageView = UIImageView(image: UIImage(named:weatherImages[0]))
        case 1:
            weatherImageView = UIImageView(image: UIImage(named:weatherImages[1]))
        case 2:
            weatherImageView = UIImageView(image: UIImage(named:weatherImages[2]))
        case 3:
            weatherImageView = UIImageView(image: UIImage(named:weatherImages[3]))
        case 4:
            weatherImageView = UIImageView(image: UIImage(named:weatherImages[4]))
        
        
        default:
            weatherImageView.image = nil
            
            return weatherImageView
        }
        return weatherImageView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 選択時の処理
        print(weatherPickerView)
        
        // ここを修正
        
        weatherlabel.text = weatherImages[row]
    }
    

    @IBAction func selectImage() {
        let alertController = UIAlertController(title: "画像選択", message: "シェアする画像を選択して下さい。", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { (action) in
            // カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではカメラが使用出来ません。")
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "フォトライブラリから選択", style: .default) { (action) in
            // アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではフォトライブラリが使用出来ません。")
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sharePhoto() {
        SVProgressHUD.show()
        
        // 撮影した画像をデータ化したときに右に90度回転してしまう問題の解消
        UIGraphicsBeginImageContext(resizedImage.size)
        let rect = CGRect(x: 0, y: 0, width: resizedImage.size.width, height: resizedImage.size.height)
        resizedImage.draw(in: rect)
        resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let data = UIImagePNGRepresentation(resizedImage)
        // ここを変更（ファイル名無いので）
        let file = NCMBFile.file(with: data) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "画像アップロードエラー", message: error!.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                // 画像アップロードが成功
                let postObject = NCMBObject(className: "Post")
                
                if self.postTextView.text.characters.count == 0 {
                    print("入力されていません")
                    return
                }
                postObject?.setObject(self.titleTextView.text!, forKey: "title")
                postObject?.setObject(self.postTextView.text!, forKey: "text")
                // weatherフィールドをニフティで作って！
                postObject?.setObject(self.weatherlabel.text!, forKey: "weather")
                postObject?.setObject(self.dayTextField.text!, forKey: "day")
                postObject?.setObject(self.monthTextField.text!, forKey: "month")
                postObject?.setObject(NCMBUser.current(), forKey: "user")
                let url = "https://mb.api.cloud.nifty.com/2013-09-01/applications/v5LRxcgGtZmRyONA/publicFiles/" + file.name
                postObject?.setObject(url, forKey: "imageUrl")
                postObject?.saveInBackground({ (error) in
                    if error != nil {
                        SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    } else {
                        SVProgressHUD.dismiss()
                        self.postImageView.image = nil
                        self.postImageView.image = UIImage(named: "photo-placeholder")
                        self.postTextView.text = nil
                        self.titleTextView.text = nil
                        self.dayTextField.text = nil
                        self.monthTextField.text = nil
                        
                        self.tabBarController?.selectedIndex = 0
                    }
                })
            }
        }) { (progress) in
            print(progress)
        }
    }
    
    func confirmContent() {
        if postTextView.text.characters.count > 0 && titleTextView.text.characters.count > 0 && (dayTextField.text?.characters.count)! > 0 && (monthTextField.text?.characters.count)! > 0 && postImageView.image != placeholderImage {
            postButton.isEnabled = true
        } else {
            postButton.isEnabled = false
        }
    }
    
    // 記入エリア以外のところをタップするとキーボードを閉じれるコード
    @IBAction func tapScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // 写真加工画面に値を受け渡すコード
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toFilterEdit" {
            let detailViewController = segue.destination as! FilterEditViewController
            
            detailViewController.selectedImage = resizedImage
            
            
        }
        
    }
    
    @IBAction func cancel() {
        if postTextView.isFirstResponder == true {
            postTextView.resignFirstResponder()
        }
        
        let alert = UIAlertController(title: "内容の破棄", message: "入力中の内容を破棄しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.postTextView.text = nil
            self.titleTextView.text = nil
            self.monthTextField.text = nil
            self.dayTextField.text = nil
            self.postImageView.image = UIImage(named: "photo-placeholder")
            self.confirmContent()
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    
}
