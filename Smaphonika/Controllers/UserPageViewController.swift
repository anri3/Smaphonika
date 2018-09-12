//
//  UserPageViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/07/14.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import SVProgressHUD

class UserPageViewController: UIViewController, UICollectionViewDataSource {
    
    var posts = [Post]()
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userDisplayNameLabel: UILabel!
    @IBOutlet var userIntroductionTextView: UITextView!
    @IBOutlet var postCollectionView: UICollectionView!
    @IBOutlet var postCountLabel: UILabel!
    @IBOutlet var followerCountLabel: UILabel!
    @IBOutlet var followingCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        postCollectionView.dataSource = self
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadPosts()
        
        loadFollowingInfo()
        
        loadLikeUserInfo()
        
        
            if let user = NCMBUser.current() {
            userDisplayNameLabel.text = user.object(forKey: "displayName") as? String
            userIntroductionTextView.text = user.object(forKey: "introduction") as? String
                let userId = NCMBUser.current().userName
            self.navigationItem.title = user.userName
            
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
            // NCMBUser.current() がnilだった時
            // ログアウト成功
            let storyboard = UIStoryboard(name: "SighIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            
            //ログアウト状態の保持
            let ud = UserDefaults.standard
            ud.set(false, forKey: "isLogin")
            ud.synchronize()
        }
        
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let photoImageView = cell.viewWithTag(1) as! UIImageView
        let photoImagePath = posts[indexPath.row].imageUrl
        photoImageView.kf.setImage(with: URL(string: photoImagePath))
        return cell
    }
    
    /* Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /* [indexPath.row] から画像名を探し、UImage を設定
        //posts = UIImage(named: posts[indexPath.row])
        if postCollectionView != nil {*/
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toCollectionViewSeeController",sender: nil)
        
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toCollectionViewSeeController") {
            let subVC: CollectionViewSeeController = (segue.destination as? CollectionViewSeeController)!
            // SubViewController のselectedImgに選択された画像を設定する
            subVC.selectedImg = 
        }
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 4
        let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace
        
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }*/
    

    @IBAction func showMenu() {
        let alertController = UIAlertController(title: "オプション", message: "", preferredStyle: .actionSheet)
        let sighOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil {
                    print("error")
                } else {
                    // ログアウト成功
                    let storyboard = UIStoryboard(name: "SighIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //ログアウト状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            })
        }
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            
            let alert = UIAlertController(title: "会員登録の解除", message: "本当に退会しますか？退会した場合、再度このアカウントをご利用頂くことができません。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                // ユーザーのアクティブ状態をfalseに
                if let user = NCMBUser.current() {
                    user.setObject(false, forKey: "active")
                    user.saveInBackground({ (error) in
                        if error != nil {
                            SVProgressHUD.showError(withStatus: error!.localizedDescription)
                        } else {
                            // userのアクティブ状態を変更できたらログイン画面に移動
                            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                            UIApplication.shared.keyWindow?.rootViewController = rootViewController
                            
                            // ログイン状態の保持
                            let ud = UserDefaults.standard
                            ud.set(false, forKey: "isLogin")
                            ud.synchronize()
                        }
                    })
                } else {
                    // userがnilだった場合ログイン画面に移動
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    // ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
                
            })
            
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(sighOutAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadPosts() {
        let query = NCMBQuery(className: "Post")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: NCMBUser.current())
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                self.posts = [Post]()
                
                for postObject in result as! [NCMBObject] {
                    // ユーザー情報をUserクラスにセット
                    let user = postObject.object(forKey: "user") as! NCMBUser
                    let userModel = User(objectId: user.objectId, userName: user.userName)
                    userModel.displayName = user.object(forKey: "displayName") as? String
                    
                    // 投稿の情報を取得
                    let imageUrl = postObject.object(forKey: "imageUrl") as! String
                    let text = postObject.object(forKey: "text") as! String
                    
                    // 2つのデータ(投稿情報と誰が投稿したか?)を合わせてPostクラスにセット
                    let post = Post(objectId: postObject.objectId, user: userModel, imageUrl: imageUrl, text: text, title: text, day: text, month: text, weather: text, createDate: postObject.createDate)
                    
                    // likeの状況(自分が過去にLikeしているか？)によってデータを挿入
                    let likeUser = postObject.object(forKey: "likeUser") as? [String]
                    if likeUser?.contains(NCMBUser.current().objectId) == true {
                        post.isLiked = true
                    } else {
                        post.isLiked = false
                    }
                    // 配列に加える
                    self.posts.append(post)
                }
                self.postCollectionView.reloadData()
                
                // post数を表示
                self.postCountLabel.text = String(self.posts.count)
            }
        })
    }
    
    func loadFollowingInfo() {
        // フォロー中
        let followingQuery = NCMBQuery(className: "Follow")
        followingQuery?.includeKey("user")
        followingQuery?.whereKey("user", equalTo: NCMBUser.current())
        followingQuery?.countObjectsInBackground({ (count, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                // 非同期通信後のUIの更新はメインスレッドで
                DispatchQueue.main.async {
                    self.followingCountLabel.text = String(count)
                }
            }
        })
        
        // フォロワー
        let followerQuery = NCMBQuery(className: "Follow")
        followerQuery?.includeKey("following")
        followerQuery?.whereKey("following", equalTo: NCMBUser.current())
        followerQuery?.countObjectsInBackground({ (count, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    // 非同期通信後のUIの更新はメインスレッドで
                    self.followerCountLabel.text = String(count)
                }
            }
        })
    }
    
    func loadLikeUserInfo() {
        // いいね総数
        let likeUserQuery = NCMBQuery(className: "Post")
        likeUserQuery?.includeKey("likeUser")
        likeUserQuery?.whereKey("user", equalTo: NCMBUser.current())
        likeUserQuery?.countObjectsInBackground({ (count, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                // 非同期通信後のUIの更新はメインスレッドで
                DispatchQueue.main.async {
                    
                }
            }
        })
    }
   
}
