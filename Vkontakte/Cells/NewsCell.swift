import UIKit
import RealmSwift
import Kingfisher

class NewsCell: UITableViewCell {
    @IBOutlet weak var sourceAvatar: UIImageView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var newsPhotos: UIImageView!
    
    @IBAction func likeButton(_ sender: Any) {
    }
    @IBOutlet weak var likeCounter: UILabel!
    
    @IBAction func commentButton(_ sender: Any) {
    }
    @IBOutlet weak var commentCounter: UILabel!
    
    @IBAction func shareButton(_ sender: Any) {
    }
    @IBOutlet weak var shareCounter: UILabel!
    
    @IBOutlet weak var viewCounter: UILabel!
    
    private let dateFormater: DateFormatter = {
        let dF = DateFormatter()
        dF.dateFormat = "HH:mm dd-MM-yyyy"
        return dF
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with news: News?) {
        
        guard var sourceId = news?.sourceId else {return}
        var postAuthor: String = ""
        var avatarURL: String = ""
        var postDate: Date = Date.distantPast
        var postImageUrl: String = ""
        guard sourceId != 0 else {return}
        if sourceId > 0 {
            if news == nil {
                return
            }
            guard let sourceDB = try? Realm().objects(Friend.self).filter("id == %@", sourceId),
                let friend = sourceDB.first
                else {return}
            postAuthor = friend.firstName + " " + friend.lastName
            avatarURL = friend.avatar
            postDate = Date(timeIntervalSince1970: news?.date ?? 0)
            postImageUrl = news?.postPhoto ?? ""
            
        } else {
            sourceId = -sourceId
            if news == nil {
                return
            }
            guard let sourceDB = try? Realm().objects(Group.self).filter("id == %@", sourceId),
                let group = sourceDB.first
                else {return}
            postAuthor = group.groupName
            avatarURL = group.groupAvatar
            postDate = Date(timeIntervalSince1970: news?.date ?? 0)
            postImageUrl = news?.postPhoto ?? ""
        }
        sourceAvatar.kf.setImage(with: URL(string: avatarURL))
        sourceName.text = postAuthor
        dateLabel.text = dateFormater.string(from: postDate)
        textView.text = news?.newsText
        imageView?.kf.setImage(with: URL(string: postImageUrl))
        likeCounter.text = String(news?.likesCount ?? 0 )
        commentCounter.text = String(news?.commentsCount ?? 0)
        
//        if news?.userLike == 1{
//            likeButton.setImage(UIImage(named: "FullHeart"), for: .normal)
//        }
    }
}
