import UIKit
import Kingfisher

class MyGroupsCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with group: Group) {
        groupName.text = group.groupName
        let url = URL(string: group.groupAvatar)
        groupImage.kf.setImage(with: url)
    }

}
