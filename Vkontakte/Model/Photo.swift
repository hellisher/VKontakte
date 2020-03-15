import RealmSwift
import SwiftyJSON

class Photo {
    let id: Int
    let date: Date
    let width: Int
    let height: Int
    let url: URL
    
    var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }
    
    init?(json: JSON) {
        guard let sizesArray = json["photo"]["sizes"].array,
            let xSize = sizesArray.first(where: { $0["type"].stringValue == "x" }),
            let url = URL(string: xSize["url"].stringValue) else { return nil }
        
        self.width = xSize["width"].intValue
        self.height = xSize["height"].intValue
        self.url = url
        let timeInterval = json["date"].doubleValue
        self.date = Date(timeIntervalSince1970: timeInterval)
        self.id = json["id"].intValue
    }
}

