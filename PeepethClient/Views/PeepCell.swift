//
//  PeepCell.swift
//  PeepethClient
//

import UIKit

class PeepCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var sharedLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var attachedImage: UIImageView!
    
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    var peep: ServerPeep! {
        didSet {
            peepSetConfigure()
        }
    }
    
    func peepSetConfigure() {
        userAvatar.layer.cornerRadius = userAvatar.frame.size.width / 2
        userAvatar.clipsToBounds = true
        userNameLabel.text = peep.info["realName"] as? String
        nickNameLabel.text = (peep.info["name"] != nil) ? "@"+(peep.info["name"] as? String)! : nil
        messageLabel.text = peep.info["content"] as? String
        
        print(messageLabel.text!)
        if let imageData = peep.info["avatar_imageData"] {
            let image = UIImage(data: imageData as! Data)
            self.userAvatar.image = image
        } else {
            self.userAvatar.image = UIImage(named: "peepLogo")
        }
        
        if let attachedImageData = peep.info["attached_imageData"] {
            let image = UIImage(data: attachedImageData as! Data)
            self.attachedImage.image = image
            self.attachedImage.isHidden = false
        } else {
            self.attachedImage.image = nil
            self.attachedImage.isHidden = true
        }
        
        // if peep has parent or it is shared
        sharedLabel.isHidden = peep.shared || peep.parent ? false : true
        leftConstraint.constant = peep.shared || peep.parent ? 25 : 5
        if peep.shared {
            sharedLabel.text = "Shared"
        }
        if peep.parent {
            sharedLabel.text = "Replied"
        }
        if !peep.parent && !peep.shared {
            self.separatorView.backgroundColor = UIColor.lightGray
        } else {
            self.separatorView.backgroundColor = UIColor.white
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.userNameLabel.text = ""
        self.nickNameLabel.text = ""
        self.messageLabel.text = ""
        self.userAvatar.image = UIImage(named: "peepLogo")
        self.sharedLabel.isHidden = true
        self.separatorView.backgroundColor = UIColor.white
        self.leftConstraint.constant = 5
        self.attachedImage.image = nil
    }
    
}
