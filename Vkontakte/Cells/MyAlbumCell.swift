//
//  AlbumCell.swift
//  Vkontakte
//
//  Created by Валерий Эль-Хатиб on 21.10.2019.
//  Copyright © 2019 EVM Corporation. All rights reserved.
//

import UIKit

class MyAlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhotos: UIImageView!
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
