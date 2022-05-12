import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    
    // MARK: Private
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private var arrayOfDetailedAnnotations: [MyAnnotation] = []
    private var locationOfVisitedPlaces = [Place]() {
        didSet {
            for item in locationOfVisitedPlaces {
                let geocoder = CLGeocoder()
                let address = "\(item.country), \(item.city)"
                geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                    if((error) != nil){
                        print("Error", error ?? "")
                    }
                    if let placemark = placemarks?.first {
                        let coordinates: CLLocationCoordinate2D = placemark.location!.coordinate
                        item.placeLatitude = coordinates.latitude
                        item.placeLongitude = coordinates.longitude
                    }
                    let detailedAnnotation = MyAnnotation(
                        title: item.country,
                        subtitle: item.city,
                        flag: item.flagUnicode,
                        coordinate: CLLocationCoordinate2D(latitude: item.placeLatitude, longitude: item.placeLongitude)
                    )
                    self.arrayOfDetailedAnnotations.append(detailedAnnotation)
                    self.mapView.addAnnotation(detailedAnnotation)
                    if detailedAnnotation.coordinate.latitude == 0.0 && detailedAnnotation.coordinate.longitude == 0.0 {
                        self.mapView.removeAnnotation(detailedAnnotation)
                    }
                })
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addSubviews()
        addConstraints()
        setupUI()
        mapView.register(MyAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let places = CoreDataManager.instance.getPlace() else { return }
        locationOfVisitedPlaces = places
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        view.addSubview(mapView)
    }
    
    private func addConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupUI() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = false
        let userLatitude = locationManager.location?.coordinate.latitude
        let userLongitude = locationManager.location?.coordinate.longitude
        let userLocation = CLLocationCoordinate2D(
            latitude: userLatitude ?? 53.904541,
            longitude: userLongitude ?? 27.561523
        )
        let coordinatesRegion = MKCoordinateRegion(
            center: userLocation,
            latitudinalMeters: 3000000,
            longitudinalMeters: 3000000
        )
        mapView.setRegion(coordinatesRegion, animated: true)
        
    // MARK: - Extensions
        
    }
}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}
