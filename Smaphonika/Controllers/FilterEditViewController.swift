//
//  FilterEditViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/07.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import Sketch

class FilterEditViewController: UIViewController {
    
   
    // UIパーツの定義
    @IBOutlet var processingImageView: UIImageView!
    @IBOutlet weak var processingScrollView: UIScrollView!
    
    // 変数の定義
    var selectedImage: UIImage!
    
    
    //UIViewクラスからインスタンス生成
    let coverView = UIView()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ImageViewに選択した画像を入れる
        processingImageView.image = selectedImage
        
        //coverViewの配置する座標とサイズを設定
        coverView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.processingImageView.bounds.width,
                                 height: self.processingImageView.bounds.height)
        
        //myImageView上にcoverViewを配置
        processingImageView.addSubview(coverView)
        //ScrollViewのコンテンツサイズの設定
        processingScrollView.contentSize = CGSize(width: 730, height: 115)
        
        //8つのButton、UIView、Labelをセット
        setEffectGroup(x: CGFloat(10), action: #selector(FilterEditViewController.tappedOriginalBtn(_:)), color: UIColor.clear, text: "オリジナル")
        setEffectGroup(x: CGFloat(100), action: #selector(FilterEditViewController.tappedRedBtn(_:)), color: UIColor.red, text: "赤")
        setEffectGroup(x: CGFloat(190), action: #selector(FilterEditViewController.tappedGreenBtn(_:)), color: UIColor.green, text: "緑")
        setEffectGroup(x: CGFloat(280), action: #selector(FilterEditViewController.tappedBlueBtn(_:)), color: UIColor.blue, text: "青")
        setEffectGroup(x: CGFloat(370), action: #selector(FilterEditViewController.tappedYellowBtn(_:)), color: UIColor.yellow,  text: "黄色")
        setEffectGroup(x: CGFloat(460), action: #selector(FilterEditViewController.tappedPurpleBtn(_:)), color: UIColor.purple, text: "紫")
        setEffectGroup(x: CGFloat(550), action: #selector(FilterEditViewController.tappedCyanBtn(_:)), color: UIColor.cyan, text: "水色")
        setEffectGroup(x: CGFloat(640), action: #selector(FilterEditViewController.tappedWhiteBtn(_:)), color: UIColor.white, text: "白")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @objc func tappedOriginalBtn(_ sender: UIButton){
        print("OriginalButtonがタップされた。")
        //coverViewの背景色をclear
        coverView.backgroundColor = UIColor.clear
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    @objc func tappedRedBtn(_ sender: UIButton){
        print("RedButtonがタップされた。")
        //coverViewの背景色を赤に設定
        coverView.backgroundColor = UIColor.red
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
    @objc func tappedGreenBtn(_ sender: UIButton){
        print("GreenButtonがタップされた。")
        //coverViewの背景色を緑に設定
        coverView.backgroundColor = UIColor.green
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
    @objc func tappedBlueBtn(_ sender: UIButton){
        print("BlueButtonがタップされた。")
        //coverViewの背景色を青に設定
        coverView.backgroundColor = UIColor.blue
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
    @objc func tappedYellowBtn(_ sender: UIButton){
        print("YellowButtonがタップされた。")
        //coverViewの背景色を黄色に設定
        coverView.backgroundColor = UIColor.yellow
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
    @objc func tappedPurpleBtn(_ sender: UIButton){
        print("PurpleButtonがタップされた。")
        //coverViewの背景色を紫に設定
        coverView.backgroundColor = UIColor.purple
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
    @objc func tappedCyanBtn(_ sender: UIButton){
        print("CyanButtonがタップされた。")
        //coverViewの背景色を青緑色に設定
        coverView.backgroundColor = UIColor.cyan
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
    @objc func tappedWhiteBtn(_ sender: UIButton){
        print("WhiteButtonがタップされた。")
        //coverViewの背景色を白に設定
        coverView.backgroundColor = UIColor.white
        //coverViewの透明度を0.1に設定
        coverView.alpha = 0.1
    }
    
  
    
    //ボタンを生成する関数
    func makeButton(x: CGFloat, action: Selector )-> UIButton{
        let button = UIButton()
        button.frame = CGRect(x: x, y: 17, width: 80, height: 80)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "cat.png" ), for: UIControlState.normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 3.0
        return button
    }
    
    //ボタンをカバーするビューを生成する関数
    func makeButtonCoverView(color: UIColor) -> UIView {
        let buttonCoverView = UIView()
        buttonCoverView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        buttonCoverView.backgroundColor = color
        buttonCoverView.alpha = 0.1
        buttonCoverView.isUserInteractionEnabled = false
        return buttonCoverView
    }
    
    //ラベルの生成する関数
    func makeEffectLabel(x: CGFloat, text: String) -> UILabel{
        let effectLabel = UILabel()
        effectLabel.frame = CGRect(x: x, y: 97, width: 80, height: 20)
        effectLabel.text = text
        effectLabel.font = UIFont(name: "Helvetica-Light",size: CGFloat(15))
        effectLabel.textAlignment = NSTextAlignment.center
        effectLabel.textColor = UIColor.white
        return effectLabel
    }
    
    //エフェクトのグループをセットする関数
   func setEffectGroup(x: CGFloat, action: Selector, color: UIColor, text: String){
        let originalBtn = makeButton(x: x, action: action)
        processingScrollView.addSubview(originalBtn)
        let originalBtnCoverView = makeButtonCoverView(color: color)
        originalBtn.addSubview(originalBtnCoverView)
        let originalLabel = makeEffectLabel(x: x, text: text)
        processingScrollView.addSubview(originalLabel)
    }
    
    
    @IBAction func savePhoto() {
        // キャプチャ画像を取得.
        let myImage = processingImageView.GetImages() as UIImage
        
        let alertController = UIAlertController(title: "完了", message: "アルバムに保存しました！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            // フォトライブラリに保存
            UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil)
            // 前の画面に戻る
            self.navigationController?.popViewController(animated: true)
            
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
}

    
    extension UIView {
        
        func GetImages() -> UIImage{
            
            // キャプチャする範囲を取得.
            let rect = self.bounds
            
            // ビットマップ画像のcontextを作成.
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            
            
            // 対象のview内の描画をcontextに複写する.
            self.layer.render(in: context)
            
            
            // 現在のcontextのビットマップをUIImageとして取得.
            let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            // contextを閉じる.
            UIGraphicsEndImageContext()
            
            return capturedImage
            
        }
    
    
 }

