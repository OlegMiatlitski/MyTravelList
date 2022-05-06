import UIKit
import CoreLocation

final class DetailedViewController: UIViewController {
    
    // MARK: Private
    
    private let backgroundToAvatarView = UIView()
    private var avatarImage = UIImageView()
    private let whiteBackgroundView = UIView()
    private let countryLabel = UILabel()
    private let cityLabel = UILabel()
    private let ratingLabel = UILabel()
    private let yearLabel = UILabel()
    private let countOfDaysLabel = UILabel()
    private let distanceLabel = UILabel()
    private let locationManager = CLLocationManager()
    private let layout = UICollectionViewFlowLayout()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    private var arrayOfPhotos = [UIImage]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        addSubviews()
        addConstraints()
        setupCollectionView()
        setupUI()
        distanceFromThePlace()
    }
    
    // MARK: - API
    
    func imagesFromCoreData(object: Data?) -> [UIImage]? {
        var arrayOfImages = [UIImage]()
        guard let object = object else { return nil }
        if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
            for data in dataArray {
                if let data = data as? Data, let image = UIImage(data: data) {
                    arrayOfImages.append(image)
                }
            }
        }
        return arrayOfImages
    }

    func yearLabel(date: String) -> String? {
        var year: [Character] = []
        var index = 0
        for char in date {
            index += 1
            if index >= 7 {
                year.append(char)
            }
        }
        var optionalYear = String?("")
        for character in year {
            optionalYear?.append(character)
        }
        return optionalYear
    }
    
    func set(place: Place) {
        avatarImage.image = UIImage(data: place.placeAvatar)
        countryLabel.text = "\(place.country)  \(place.flagUnicode)"
        cityLabel.text = place.city
        ratingLabel.text = "\u{2B50} \(place.placeRating)"
        countOfDaysLabel.text = "\(place.countOfDaysStaying) d"
        arrayOfPhotos = imagesFromCoreData(object: place.collectionOfPhoto)!
        yearLabel.text = yearLabel(date: place.arrivalDay) ?? "2022"
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        view.addSubview(backgroundToAvatarView)
        backgroundToAvatarView.addSubview(avatarImage)
        view.addSubview(whiteBackgroundView)
        whiteBackgroundView.addSubview(countryLabel)
        whiteBackgroundView.addSubview(cityLabel)
        whiteBackgroundView.addSubview(yearLabel)
        whiteBackgroundView.addSubview(ratingLabel)
        whiteBackgroundView.addSubview(countOfDaysLabel)
        whiteBackgroundView.addSubview(distanceLabel)
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        backgroundToAvatarView.translatesAutoresizingMaskIntoConstraints = false
        backgroundToAvatarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        backgroundToAvatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        backgroundToAvatarView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        backgroundToAvatarView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.topAnchor.constraint(equalTo: backgroundToAvatarView.topAnchor, constant: 10).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: backgroundToAvatarView.bottomAnchor, constant: -10).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: backgroundToAvatarView.leadingAnchor, constant: 10).isActive = true
        avatarImage.trailingAnchor.constraint(equalTo: backgroundToAvatarView.trailingAnchor, constant: -10).isActive = true
        
        whiteBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        whiteBackgroundView.topAnchor.constraint(equalTo: backgroundToAvatarView.bottomAnchor, constant: 30).isActive = true
        whiteBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        whiteBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        whiteBackgroundView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor,constant: 10).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: whiteBackgroundView.leadingAnchor,constant: 15).isActive = true
        countryLabel.trailingAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor,constant: 0).isActive = true
        countryLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor,constant: 15).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: whiteBackgroundView.leadingAnchor,constant: 15).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor,constant: 0).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor,constant: 10).isActive = true
        yearLabel.leadingAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor,constant: 10).isActive = true
        yearLabel.trailingAnchor.constraint(equalTo: whiteBackgroundView.trailingAnchor,constant: -10).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        countOfDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        countOfDaysLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor,constant: 15).isActive = true
        countOfDaysLabel.leadingAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor,constant: 10).isActive = true
        countOfDaysLabel.trailingAnchor.constraint(equalTo: whiteBackgroundView.trailingAnchor,constant: -10).isActive = true
        countOfDaysLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor,constant: 15).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: whiteBackgroundView.leadingAnchor,constant: 10).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.topAnchor.constraint(equalTo: countOfDaysLabel.bottomAnchor,constant: 15).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: whiteBackgroundView.trailingAnchor,constant: -10).isActive = true
        distanceLabel.leadingAnchor.constraint(equalTo: whiteBackgroundView.centerXAnchor,constant: 10).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: whiteBackgroundView.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailedCollectionViewCell")
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 175, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        layout.scrollDirection = .horizontal
    }
    
    private func setupUI() {
        let image = UIImageView()
        image.image = UIImage(named: "detailedVC")!
        image.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(patternImage: image.image!)
        
        collectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        backgroundToAvatarView.backgroundColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        backgroundToAvatarView.layer.cornerRadius = 10
        backgroundToAvatarView.layer.masksToBounds = true
        backgroundToAvatarView.layer.shadowColor = UIColor.black.cgColor
        backgroundToAvatarView.layer.shadowOpacity = 2
        backgroundToAvatarView.layer.shadowRadius = 10
        
        avatarImage.contentMode = .scaleToFill
        avatarImage.layer.cornerRadius = 10
        avatarImage.layer.masksToBounds = true
        
        whiteBackgroundView.backgroundColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        whiteBackgroundView.layer.cornerRadius = 10
        whiteBackgroundView.layer.masksToBounds = true
        whiteBackgroundView.layer.shadowColor = UIColor.black.cgColor
        whiteBackgroundView.layer.shadowOpacity = 2
        whiteBackgroundView.layer.shadowRadius = 10
        whiteBackgroundView.layer.borderWidth = 2
        whiteBackgroundView.layer.borderColor = UIColor.white.cgColor
        
        countryLabel.backgroundColor = .clear
        countryLabel.textColor = .white
        countryLabel.textAlignment = .left
        countryLabel.font = UIFont(name: "Leto Text Sans Defect", size: 35)
        countryLabel.adjustsFontSizeToFitWidth = true
        countryLabel.numberOfLines = 0
        
        cityLabel.backgroundColor = .clear
        cityLabel.textColor = .white
        cityLabel.textAlignment = .left
        cityLabel.font = UIFont(name: "Leto Text Sans Defect", size: 35)
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.numberOfLines = 0
        
        yearLabel.backgroundColor = .clear
        yearLabel.textColor = .white
        yearLabel.textAlignment = .right
        yearLabel.font = UIFont(name: "Leto Text Sans Defect", size: 35)
        yearLabel.adjustsFontSizeToFitWidth = true
        
        countOfDaysLabel.backgroundColor = .clear
        countOfDaysLabel.textColor = .white
        countOfDaysLabel.textAlignment = .right
        countOfDaysLabel.font = UIFont(name: "Leto Text Sans Defect", size: 35)
        countOfDaysLabel.adjustsFontSizeToFitWidth = true
        
        ratingLabel.layer.borderColor = UIColor.gray.cgColor
        ratingLabel.layer.borderWidth = 3
        ratingLabel.backgroundColor = .white
        ratingLabel.layer.cornerRadius = 15
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont(name: "Leto Text Sans Defect", size: 17)
        ratingLabel.adjustsFontSizeToFitWidth = true
       
        distanceLabel.backgroundColor = .clear
        distanceLabel.textColor = .white
        distanceLabel.textAlignment = .right
        distanceLabel.font = UIFont(name: "Leto Text Sans Defect", size: 25)
        distanceLabel.adjustsFontSizeToFitWidth = true
    }
    
    func distanceFromThePlace() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let myLatitude = locationManager.location?.coordinate.latitude
        let myLongitude = locationManager.location?.coordinate.longitude
        let myLocation = CLLocation(latitude: myLatitude ?? 53.902287, longitude: myLongitude ?? 27.561824)
        
        let geocoder = CLGeocoder()
        let address = "\(countryLabel.text ?? "") , \(cityLabel.text ?? "")"
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                let placeLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                let distance = myLocation.distance(from: placeLocation)
                self.distanceLabel.text = String(format: "%.0f", distance/1000) + " km away from me"
            }
        }
        )
    }
}

// MARK: - Extensions

extension DetailedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedCollectionViewCell", for: indexPath) as? DetailedCollectionViewCell {
            cell.setPhoto(photo: arrayOfPhotos[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        avatarImage.image = arrayOfPhotos[indexPath.row]
    }
}
