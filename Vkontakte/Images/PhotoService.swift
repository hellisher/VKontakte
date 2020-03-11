import Foundation
import Alamofire

class PhotoService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private static let pathName: String = {
        
        let pathName = "Images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return pathName}
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        let hashName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url) else {return}
        let data = UIImagePNGRespresentation(image) // что это?
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        
    }
    
}
