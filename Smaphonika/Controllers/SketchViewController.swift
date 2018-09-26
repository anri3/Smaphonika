//
//  SketchViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/05.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import Sketch

class SketchViewController: UIViewController {
    
    // sketchViewを作成
    let sketchView = SketchView(frame: CGRect(x: 0, y: 108, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height -  250))
    
    // UIパーツの定義
    @IBOutlet var widthSlider: UISlider!
    @IBOutlet var alphaSlider: UISlider!
    
    
    // 画面生成時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sketchView)
        
       
        
    }
    
   
    // メモリ不足でクラッシュした時に呼ばれる
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // width調節用sliderの表示・非表示を切り替える
    @IBAction func width() {
        if widthSlider.isHidden == true {
            widthSlider.isHidden = false
        } else if widthSlider.isHidden == false {
            widthSlider.isHidden = true
        }
    }
    
    // alpha調節用sliderの表示・非表示を切り替える
    @IBAction func alpha() {
        if alphaSlider.isHidden == true {
            alphaSlider.isHidden = false
        } else if alphaSlider.isHidden == false {
            alphaSlider.isHidden = true
        }
    }
    
    // 色を変える
    @IBAction func changeColor() {
        
        let alertController = UIAlertController(title: "色を変える", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "黒", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.black
        }
        alertController.addAction(action1)
        
        
        let action2 = UIAlertAction(title: "赤", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.red
        }
        alertController.addAction(action2)
        
        let action3 = UIAlertAction(title: "オレンジ", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.orange
        }
        alertController.addAction(action3)
        
        let action4 = UIAlertAction(title: "黄色", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.yellow
        }
        alertController.addAction(action4)
        
        let action5 = UIAlertAction(title: "緑", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.green
        }
        alertController.addAction(action5)
        
        let action6 = UIAlertAction(title: "水色", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.cyan
        }
        alertController.addAction(action6)
        
        let action7 = UIAlertAction(title: "青", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.blue
        }
        alertController.addAction(action7)
        
        let action8 = UIAlertAction(title: "紫", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.purple
        }
        alertController.addAction(action8)
        
        let action9 = UIAlertAction(title: "赤紫", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.magenta
        }
        alertController.addAction(action9)
        
        let action10 = UIAlertAction(title: "茶色", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.brown
        }
        alertController.addAction(action10)
        
        let action11 = UIAlertAction(title: "グレー", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.gray
        }
        alertController.addAction(action11)
        
        let action12 = UIAlertAction(title: "白", style: .default){ (action: UIAlertAction) in
            self.sketchView.lineColor = UIColor.white
        }
        alertController.addAction(action12)
        
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,animated: true,completion: nil)
        
    }
    
    // ぺんタイプを変える
    @IBAction func changePenType() {
        
        let alertController = UIAlertController(title: "ペンタイプを変える", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "ノーマル", style: .default){ (action: UIAlertAction) in
            self.sketchView.drawingPenType = PenType.normal
        }
        alertController.addAction(action1)
        
        
        let action2 = UIAlertAction(title: "ブラー", style: .default){ (action: UIAlertAction) in
            // ブラー
            self.sketchView.drawingPenType = PenType.blur
        }
        alertController.addAction(action2)
        
        
        let action3 = UIAlertAction(title: "ネオン", style: .default){ (action: UIAlertAction) in
            // ネオン
            self.sketchView.drawingPenType = PenType.neon
        }
        alertController.addAction(action3)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,animated: true,completion: nil)
        
    }
    
    // クリアボタン
    @IBAction func clear() {
        sketchView.clear()
    }
    
    // モードを変える
    @IBAction func changeMode() {
        
        let alertController = UIAlertController(title: "モードを変える", message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "ペン", style: .default){ (action: UIAlertAction) in
            self.sketchView.drawTool = SketchToolType.pen
        }
        alertController.addAction(action1)
        
        
        let action2 = UIAlertAction(title: "消しゴム", style: .default){ (action: UIAlertAction) in
            self.sketchView.drawTool = SketchToolType.eraser
        }
        alertController.addAction(action2)
        
        let action3 = UIAlertAction(title: "四角", style: .default){ (action: UIAlertAction) in
            self.sketchView.drawTool = SketchToolType.rectangleFill
        }
        alertController.addAction(action3)
        
        let action4 = UIAlertAction(title: "丸", style: .default){ (action: UIAlertAction) in
            self.sketchView.drawTool = SketchToolType.ellipseFill
        }
        alertController.addAction(action4)
        
        let action5 = UIAlertAction(title: "矢印", style: .default){ (action: UIAlertAction) in
            self.sketchView.drawTool = SketchToolType.arrow
        }
        alertController.addAction(action5)

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,animated: true,completion: nil)
        
    }
    
    // 一つ前に戻る
    @IBAction func undo() {
        sketchView.undo()
    }
    
    // 一個前の作業に戻る
    @IBAction func redo() {
        sketchView.redo()
    }
    
    // width値を調節
    @IBAction func widthSliderAction(_ sender: UISlider) {
        sketchView.lineWidth = CGFloat(sender.value * 50)
    }
    
    // alpha値を調節
    @IBAction func alphaSliderAction(_ sender: UISlider) {
        sketchView.lineAlpha = CGFloat(sender.value)
    }
    
    @IBAction func savePhoto() {
        // キャプチャ画像を取得.
        let myImage = sketchView.GetImage() as UIImage
        
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
    
    func GetImage() -> UIImage{
        
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

