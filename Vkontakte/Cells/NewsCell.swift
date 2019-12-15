import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var newsPhotos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
