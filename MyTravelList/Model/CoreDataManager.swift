import UIKit
import CoreData

final class CoreDataManager {
    static let instance = CoreDataManager()
    
    func savePlace(_ place: Place) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PlaceEntity", in: managedContext)!
        
        let visitedPlace = NSManagedObject(entity: entity, insertInto: managedContext)
        
        visitedPlace.setValue(place.flagUnicode, forKey: "flagUnicode")
        visitedPlace.setValue(place.country, forKey: "country")
        visitedPlace.setValue(place.city, forKey: "city")
        visitedPlace.setValue(place.placeAvatar, forKey: "placeAvatar")
        visitedPlace.setValue(place.arrivalDay, forKey: "arrivalDay")
        visitedPlace.setValue(place.departureDay, forKey: "departureDay")
        visitedPlace.setValue(place.countOfDaysStaying, forKey: "countOfDaysStaying")
        visitedPlace.setValue(place.placeRating, forKey: "placeRating")
        visitedPlace.setValue(place.placeLatitude, forKey: "placeLatitude")
        visitedPlace.setValue(place.placeLongitude, forKey: "placeLongitude")
        visitedPlace.setValue(place.collectionOfPhoto, forKey: "collectionOfPhoto")
        
        do {
            try managedContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }
    
    func getPlace() -> [Place]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return nil}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlaceEntity")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            
            var visitedPlaces = [Place]()
            
            for object in objects {
                guard let flagUnicode = object.value(forKey: "flagUnicode") as? String,
                      let country = object.value(forKey: "country") as? String,
                      let city = object.value(forKey: "city") as? String,
                      let placeAvatar = object.value(forKey: "placeAvatar") as? Data,
                      let arrivalDay = object.value(forKey: "arrivalDay") as? String,
                      let departureDay = object.value(forKey: "departureDay") as? String,
                      let countOfDaysStaying = object.value(forKey: "countOfDaysStaying") as? String,
                      let placeRating = object.value(forKey: "placeRating") as? String,
                      let placeLatitude = object.value(forKey: "placeLatitude") as? Double,
                      let placeLongitude = object.value(forKey: "placeLongitude") as? Double,
                      let collectionOfPhoto = object.value(forKey: "collectionOfPhoto") as? Data
                else {
                    return nil
                }
                let place = Place(flagUnicode: flagUnicode,
                                  country: country,
                                  city: city,
                                  placeAvatar: placeAvatar,
                                  arrivalDay: arrivalDay,
                                  departureDay: departureDay,
                                  countOfDaysStaying: countOfDaysStaying,
                                  placeRating: placeRating,
                                  placeLatitude: placeLatitude,
                                  placeLongitude: placeLongitude,
                                  collectionOfPhoto: collectionOfPhoto
                )
                visitedPlaces.append(place)
            }
            return visitedPlaces
        } catch let error as NSError {
            print("Error - \(error)")
        }
        return nil
    }
    
    func deleteEntity(placesArray: [Place], indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlaceEntity")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            managedContext.delete(objects[indexPath.row])
        } catch let error as NSError {
            print(error)
        }
        do {
            try managedContext.save()
            guard let fetchArray = CoreDataManager.instance.getPlace() else {return}
            let placesArray = fetchArray
            print(placesArray)
        } catch let error as NSError {
            print(error)
        }
    }
    
    private init() { }
}

