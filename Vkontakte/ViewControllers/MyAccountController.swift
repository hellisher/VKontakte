//
//  MyAccountController.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 23.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import UIKit

class MyAccountController: UIViewController {

    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var token: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let session = Session.instance
        
        userPhoto.image = session.userPhoto
        userName.text = session.userName
        userID.text = String(session.userID)
        token.text = session.token
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
