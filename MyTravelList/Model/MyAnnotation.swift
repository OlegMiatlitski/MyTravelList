import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let flag: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, flag: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.flag = flag
        self.coordinate = coordinate
        super.init()
    }
}

class MyAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let _myAnnotation = newValue as? MyAnnotation else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let rightButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            rightButton.setTitle(_myAnnotation.flag, for: UIControl.State())
            rightCalloutAccessoryView = rightButton
        }
    }
}
