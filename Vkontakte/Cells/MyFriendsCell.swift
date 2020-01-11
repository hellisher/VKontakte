import UIKit
import Kingfisher

class MyFriendsCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with friend: Friend) {
        friendName.text = friend.firstName + " " + friend.lastName
        let url = URL(string: friend.avatar)
        friendImage.kf.setImage(with: url)
    }

}
