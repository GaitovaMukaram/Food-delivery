//
//  ImageCache.swift
//  Food-delivery
//
//  Created by Mukaram Gaitova on 29.05.2024.
//

import UIKit
import CoreData

class ImageCache {
    static let shared = ImageCache()
    
    private init() {}
    
    func saveImage(urlString: String, image: UIImage) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CachedImage", in: context)!
        let cachedImage = NSManagedObject(entity: entity, insertInto: context)
        
        cachedImage.setValue(urlString, forKey: "url")
        cachedImage.setValue(image.pngData(), forKey: "imageData")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchImage(from urlString: String) -> UIImage? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CachedImage")
        fetchRequest.predicate = NSPredicate(format: "url == %@", urlString)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let imageData = result.first?.value(forKey: "imageData") as? Data {
                return UIImage(data: imageData)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
}

