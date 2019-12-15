import UIKit

class MyFriendsPhotoViewController: UICollectionViewController {

    var friendPhoto: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFriendsPhotoCell", for: indexPath) as! MyFriendsPhotoCell
        cell.photo.image = friendPhoto
        return cell
    }

}
