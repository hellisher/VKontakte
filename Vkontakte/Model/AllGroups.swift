import Foundation
import UIKit

struct AllGroups {
    var groupName: String
    var groupAvatar: UIImage?
}

let netflix = AllGroups(groupName: "Netflix", groupAvatar: UIImage(named: "NetflixGroupImage"))
let tesla = AllGroups(groupName: "Tesla", groupAvatar: UIImage(named: "TeslaGroupImage"))
let yandex = AllGroups(groupName: "Yandex", groupAvatar: UIImage(named: "ЯндексGroupImage"))

let globalGroups = [netflix, tesla, yandex]
