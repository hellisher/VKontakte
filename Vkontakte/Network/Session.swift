import Foundation
import UIKit

class Session {
    
    static let instance = Session()
    
    private init () {}
    
    var userName:String = "Valerii El-Khatib"
    var userPhoto: UIImage = UIImage(named: "El-Khatib")!
    var userID: String = ""
    var token: String = ""
    
}
