import Foundation
import Firebase

class FirebaseAPI {
    
    static let shared = FirebaseAPI()
    
    private init () {}
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            print(result.debugDescription)
            print(error.debugDescription)
        }
    }
    
    func authorizeUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            print(result.debugDescription)
            print(error.debugDescription)
            print(result?.user.uid as Any)
        }
    }
    
    func writeUser(name: String, id: String, properties: [String: Any]) {
        let ref = Database.database().reference(withPath: "users")
        let newUser = ref.child(id)
        var userProperties = [String: Any]()
        userProperties["name"] = name
        for property in properties {
            userProperties[property.key] =  property.value
        }
        
        newUser.setValue(userProperties)
        
    }
    
    func addUserGroup(name: String, id: String, properties: [String: Any]) {
        let ref  = Database.database().reference(withPath: "user_groups")
        let newUserGroup = ref.child(id)
        var groupProperties = [String: Any]()
        groupProperties["name"] = name
        for property in properties {
            groupProperties[property.key] = property.value
        }
        newUserGroup.setValue(groupProperties)
    }
    
}
