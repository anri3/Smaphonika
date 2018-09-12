//
//  TimelineTableViewCell.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/02.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit
import TTTAttributedLabel

protocol TimelineTableViewCellDelegate {
    func didTapLikeButton(tableViewCell: UITableViewCell, button: UIButton)
    func didTapMenuButton(tableViewCell: UITableViewCell, button: UIButton)
    func didTapCommentsButton(tableViewCell: UITableViewCell, button: UIButton)
}


class TimelineTableViewCell: UITableViewCell {
    
    var delegate: TimelineTableViewCellDelegate?
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var titleTextView: UITextView!
    
    @IBOutlet var monthTextField: UITextField!
    
    @IBOutlet var dayTextField: UITextField!
    
    @IBOutlet var weatherLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet var commentButton: UIButton!
    
    @IBOutlet var likeCountLabel: UILabel!
    
    @IBOutlet var userCommentTextView: UITextView!
    
    @IBOutlet var weatherImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.clipsToBounds = true
        
        userNameLabel.adjustsFontSizeToFitWidth = true
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func like(button: UIButton) {
        self.delegate?.didTapLikeButton(tableViewCell: self, button: button)
    }
    
    @IBAction func openMenu(button: UIButton) {
        self.delegate?.didTapMenuButton(tableViewCell: self, button: button)
    }
    
    @IBAction func showComments(button: UIButton) {
        self.delegate?.didTapCommentsButton(tableViewCell: self, button: button)
    }

    
}
