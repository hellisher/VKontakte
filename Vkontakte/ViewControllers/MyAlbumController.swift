import UIKit
import RealmSwift

class MyAlbumController: UICollectionViewController {
    
    var userPhotos = [UserPhoto]()
    var api = GetVKAPI()
    var token: NotificationToken?
    
    func load(url: URL, completion: @escaping (UIImage) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = RealmDatabase.shared.changesInTheUserPhotosData()
        
        api.loadUserPhotosData() { [weak self] in
            DispatchQueue.main.async {
                self?.userPhotos = RealmDatabase.shared.loadUserPhotosData()
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyAlbumCell", for: indexPath) as! MyAlbumCell
//        load(url: userPhotos[indexPath.row].userPhoto) { image in
//            cell.userPhotos.image = image
//        }
        return cell
    }
}
