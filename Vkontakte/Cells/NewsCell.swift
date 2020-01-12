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
        let dateTransformater = DateFormatter()
        dateTransformater.dateFormat = "HH:mm dd-MM-yyyy"
        return dateTransformater
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
        var postAuthorAvatar: String = ""
        var postDate: Date = Date.distantPast
        var postText: String = ""
        var postPhotos: String = ""
        guard sourceId != 0 else {return}
        if sourceId > 0 {
            if news == nil {
                return
            }
            guard let sourceDB = try? Realm().objects(Friend.self).filter("id == %@", sourceId),
                let friend = sourceDB.first
                else {return}
            postAuthor = friend.firstName + " " + friend.lastName
            postAuthorAvatar = friend.avatar
            postDate = Date(timeIntervalSince1970: news?.date ?? 0)
            postText = news?.newsText ?? ""
            postPhotos = news?.postPhoto ?? ""
            
        } else {
            sourceId = -sourceId
            if news == nil {
                return
            }
            guard let sourceDB = try? Realm().objects(Group.self).filter("id == %@", sourceId),
                let group = sourceDB.first
                else {return}
            postAuthor = group.groupName
            postAuthorAvatar = group.groupAvatar
            postDate = Date(timeIntervalSince1970: news?.date ?? 0)
            postText = news?.newsText ?? ""
            postPhotos = news?.postPhoto ?? ""
        }
        sourceAvatar.kf.setImage(with: URL(string: postAuthorAvatar))
        sourceName.text = postAuthor
        dateLabel.text = dateFormater.string(from: postDate)
        textView.text = postText
        newsPhotos?.kf.setImage(with: URL(string: postPhotos))
        likeCounter.text = String(news?.likesCount ?? 0 )
        commentCounter.text = String(news?.commentsCount ?? 0)
    }
}
