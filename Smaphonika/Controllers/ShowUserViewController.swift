//
//  ShowUserViewController.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/05.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import SVProgressHUD

class ShowUserViewController: UIViewController, UICollectionViewDataSource {
    
    var selectedUser: NCMBUser!
    
    var followingInfo: NCMBObject?
    
    var posts = [Post]()
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userDisplayNameLabel: UILabel!
    
    @IBOutlet var userIntroductionTextView: UITextView!
    
    @IBOutlet var photoCollectionView: UICollectionView!
    
    @IBOutlet var postCountLabel: UILabel!
    
    @IBOutlet var followerCountLabel: UILabel!
    
    @IBOutlet var followingCountLabel: UILabel!
    
    @IBOutlet var followButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.dataSource = self
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
        // ユーザー基礎情報の読み込み
        userDisplayNameLabel.text = selectedUser.object(forKey: "displayName") as? String
        userIntroductionTextView.text = selectedUser.object(forKey: "introduction") as? String
        self.navigationItem.title = selectedUser.userName
        
        // プロフィール画像の読み込み
        let file = NCMBFile.file(withName: selectedUser.objectId, data: nil) as! NCMBFile
        file.getDataInBackground { (data, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if data != nil {
                    let image = UIImage(data: data!)
                    self.userImageView.image = image
                }
            }
        }
        
        // ユーザーの投稿した写真の読み込み
        loadPosts()
        
        // フォロー状態の読み込み
        loadFollowingStatus()
        
        // フォロー数の読み込み
        loadFollowingInfo()
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
    
    func loadFollowingStatus() {
        let query = NCMBQuery(className: "Follow")
        query?.includeKey("user")
        query?.includeKey("following")
        query?.whereKey("user", equalTo: NCMBUser.current())
        
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            } else {
                for following in result as! [NCMBObject] {
                    let user = following.object(forKey: "following") as! NCMBUser
                    
                    // フォロー状態だった場合、ボタンの表示を変更
                    if self.selectedUser.objectId == user.objectId {
                        // 表示変更を高速化するためにメインスレッドで処理
                        DispatchQueue.main.async {
                            self.followButton.setTitle("フォロー解除", for: .normal)
                            self.followButton.setTitleColor(UIColor.black, for: .normal)
                            // self.followButton.borderColor = UIColor.red
                        }
                        
                        // フォロー状態を管理するオブジェクトを保存
                        self.followingInfo = following
                        break
                    }
                }
            }
        })
    }
    
    func loadPosts() {
        let query = NCMBQuery(className: "Post")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: selectedUser)
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
                self.photoCollectionView.reloadData()
                
                // post数を表示
                self.postCountLabel.text = String(self.posts.count)
            }
        })
    }
    
    func loadFollowingInfo() {
        // フォロー中
        let followingQuery = NCMBQuery(className: "Follow")
        followingQuery?.includeKey("user")
        followingQuery?.whereKey("user", equalTo: selectedUser)
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
        followerQuery?.whereKey("following", equalTo: selectedUser)
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
    
    @IBAction func follow() {
        // すでにフォロー状態だった場合、フォロー解除
        if let info = followingInfo {
            info.deleteInBackground({ (error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.followButton.setTitle("フォローする", for: .normal)
                        self.followButton.setTitleColor(UIColor.black, for: .normal)
                        // self.followButton.borderColor = UIColor.blue
                    }
                    
                    // フォロー状態の再読込
                    self.loadFollowingStatus()
                    
                    // フォロー数の再読込
                    self.loadFollowingInfo()
                }
            })
        } else {
            let displayName = selectedUser.object(forKey: "displayName") as? String
            let message = displayName! + "をフォローしますか？"
            let alert = UIAlertController(title: "フォロー", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                let object = NCMBObject(className: "Follow")
                if let currentUser = NCMBUser.current() {
                    object?.setObject(currentUser, forKey: "user")
                    object?.setObject(self.selectedUser, forKey: "following")
                    object?.saveInBackground({ (error) in
                        if error != nil {
                            SVProgressHUD.showError(withStatus: error!.localizedDescription)
                        } else {
                            self.loadFollowingStatus()
                        }
                    })
                } else {
                    // currentUserが空(nil)だったらログイン画面へ
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    // ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            }
            let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
