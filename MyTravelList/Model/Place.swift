import UIKit

final class Place {
    let flagUnicode: String
    let country: String
    let city: String
    var placeAvatar: Data {
        didSet { _ = UIImage(data: placeAvatar)! }
    }
    let arrivalDay: String
    let departureDay: String
    let countOfDaysStaying: String
    let placeRating: String
    var placeLatitude: Double
    var placeLongitude: Double
    var collectionOfPhoto: Data
    
    init(
        flagUnicode: String,
        country: String,
        city: String,
        placeAvatar: Data,
        arrivalDay: String,
        departureDay: String,
        countOfDaysStaying: String,
        placeRating: String,
        placeLatitude: Double,
        placeLongitude: Double,
        collectionOfPhoto: Data
    )
    {
        self.flagUnicode = flagUnicode
        self.country = country
        self.city = city
        self.placeAvatar = placeAvatar
        self.arrivalDay = arrivalDay
        self.departureDay = departureDay
        self.countOfDaysStaying = countOfDaysStaying
        self.placeRating = placeRating
        self.placeLatitude = placeLatitude
        self.placeLongitude = placeLongitude
        self.collectionOfPhoto = collectionOfPhoto
    }
}
