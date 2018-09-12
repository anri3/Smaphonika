//
//  SearchTableViewCell.swift
//  Smaphonika
//
//  Created by 米山杏里 on 2018/08/05.
//  Copyright © 2018年 jp.yoneyamaanri. All rights reserved.
//

import UIKit

protocol SearchTableViewCellDelegate {
    func didTapFollowButton(tableViewCell: UITableViewCell, button: UIButton)
}




class SearchTableViewCell: UITableViewCell {
    
    var delegate: SearchTableViewCellDelegate?
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var followButton: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userNameLabel.adjustsFontSizeToFitWidth = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func follow(button: UIButton) {
        self.delegate?.didTapFollowButton(tableViewCell: self, button: button)
    }
    
}
