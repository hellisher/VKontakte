import Foundation

class News: Decodable {
    
    var date: Date
    var text: String
    
    enum NewsKeys: String, CodingKey {
        case date
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.text = try container.decode(String.self, forKey: .text)
    }
}
