import Foundation
import UIKit

class Session {
    
    static let instance = Session()
    
    private init () {}
    
    var userID: String = ""
    var token: String = ""
    
}
