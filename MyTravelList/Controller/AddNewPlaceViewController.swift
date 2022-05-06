import UIKit
import CoreLocation

protocol TransferDataBetweenVCDelegats: AnyObject {
    func transferPhoto(_ photo: [UIImageView])
}

final class AddNewPlaceViewController: UIViewController {
    
    // MARK: Private
    
    private let backgroundRectangle = UIView()
    private let pickerImageView = UIImageView()
    private let placeAvatar = UIImageView()
    private let avatarButton = UIButton()
    private let countryTextField = UITextField()
    private let cityTextField = UITextField()
    private let arrivalDayTextField = UITextField()
    private let departureDayTextField = UITextField()
    private let starImage = UIImageView()
    private let starLabel = UILabel()
    private let saveButton = UIButton()
    private let flagLabel = UILabel()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let ratingLabel = UILabel()
    private var countriesPickerView = UIPickerView()
    private let addPhotosButton = UIButton()
    private var selectedRating: Int = 5
    private var countriesData = [(name:String,flag:String)]()
    private let arrayOfMarks: [Int] = [1,2,3,4,5]
    private var firstDay = Date()
    private var secondDay = Date()
    private var arrayOfPhoto: [UIImageView] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setupUI()
        setupCountry()
        keyboardForDescriptionTextView()
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        view.addSubview(backgroundRectangle)
        view.addSubview(countryTextField)
        view.addSubview(cityTextField)
        view.addSubview(flagLabel)
        view.addSubview(placeAvatar)
        view.addSubview(pickerImageView)
        view.addSubview(avatarButton)
        view.addSubview(arrivalDayTextField)
        view.addSubview(departureDayTextField)
        view.addSubview(starImage)
        view.addSubview(starLabel)
        view.addSubview(ratingLabel)
        view.addSubview(minusButton)
        view.addSubview(plusButton)
        view.addSubview(addPhotosButton)
        view.addSubview(saveButton)
    }
    
    private func addConstraints() {
        
        backgroundRectangle.translatesAutoresizingMaskIntoConstraints = false
        backgroundRectangle.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        placeAvatar.translatesAutoresizingMaskIntoConstraints = false
        placeAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        placeAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        placeAvatar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        placeAvatar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        pickerImageView.translatesAutoresizingMaskIntoConstraints = false
        pickerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        pickerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pickerImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pickerImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        avatarButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        avatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        avatarButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        avatarButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        flagLabel.topAnchor.constraint(equalTo: placeAvatar.bottomAnchor, constant: 20).isActive = true
        flagLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        flagLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        flagLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        countryTextField.topAnchor.constraint(equalTo: placeAvatar.bottomAnchor, constant: 20).isActive = true
        countryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        countryTextField.trailingAnchor.constraint(equalTo: flagLabel.leadingAnchor, constant: -10).isActive = true
        countryTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 20).isActive = true
        cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        cityTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        arrivalDayTextField.translatesAutoresizingMaskIntoConstraints = false
        arrivalDayTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20).isActive = true
        arrivalDayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        arrivalDayTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        arrivalDayTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        departureDayTextField.translatesAutoresizingMaskIntoConstraints = false
        departureDayTextField.topAnchor.constraint(equalTo: arrivalDayTextField.bottomAnchor, constant: 15).isActive = true
        departureDayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        departureDayTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        departureDayTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 40).isActive = true
        minusButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        starImage.translatesAutoresizingMaskIntoConstraints = false
        starImage.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20).isActive = true
        starImage.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 10).isActive = true
        starImage.widthAnchor.constraint(equalToConstant: 65).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.centerXAnchor.constraint(equalTo: starImage.centerXAnchor, constant: 0).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor, constant: 0).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 40).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 10).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        addPhotosButton.translatesAutoresizingMaskIntoConstraints = false
        addPhotosButton.topAnchor.constraint(equalTo: departureDayTextField.bottomAnchor, constant: 15).isActive = true
        addPhotosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addPhotosButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        addPhotosButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setupUI() {
        
        title = "Add a new place"
        
        backgroundRectangle.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        let image = UIImageView()
        image.image = UIImage(named: "background")!
        image.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(patternImage: image.image!)
        
        placeAvatar.image = UIImage(named: "addAvatarImage")
        placeAvatar.backgroundColor = .white
        placeAvatar.layer.cornerRadius = 12
        placeAvatar.layer.masksToBounds = true
        
        pickerImageView.image = UIImage(named: "addAvatarImage")
        
        avatarButton.backgroundColor = .clear
        avatarButton.layer.cornerRadius = 12
        avatarButton.layer.masksToBounds = true
        avatarButton.addTarget(self, action: #selector(setMoviePic), for: .touchUpInside)
        
        countryTextField.backgroundColor = .white
        countryTextField.layer.cornerRadius = 10
        countryTextField.textAlignment = .left
        countryTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter a country name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        countryTextField.font = UIFont(name: "Leto Text Sans Defect", size: 20)
        countryTextField.textColor = .systemGreen
        countryTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: cityTextField.frame.height))
        countryTextField.leftViewMode = .always
        
        //        countriesPickerView
        
        countriesPickerView.delegate = self
        countriesPickerView.dataSource = self
        countryTextField.inputView = countriesPickerView
        countryTextField.endEditing(true)
        
        flagLabel.backgroundColor = .clear
        flagLabel.font = .systemFont(ofSize: 40)
        
        cityTextField.backgroundColor = .white
        cityTextField.layer.cornerRadius = 10
        cityTextField.layer.masksToBounds = true
        cityTextField.textAlignment = .left
        cityTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter a city name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        cityTextField.font = UIFont(name: "Leto Text Sans Defect", size: 20)
        cityTextField.textColor = .systemGreen
        cityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: cityTextField.frame.height))
        cityTextField.leftViewMode = .always
        
        arrivalDayTextField.backgroundColor = .white
        arrivalDayTextField.layer.cornerRadius = 5
        arrivalDayTextField.layer.masksToBounds = true
        arrivalDayTextField.textAlignment = .center
        arrivalDayTextField.attributedPlaceholder = NSAttributedString(
            string: "Arrival date",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        arrivalDayTextField.font = UIFont(name: "Leto Text Sans Defect", size: 20)
        arrivalDayTextField.textColor = .black
        arrivalDayTextField.setInputView(target: self, selector: #selector(saveArrivalDate))
        
        departureDayTextField.backgroundColor = .white
        departureDayTextField.layer.cornerRadius = 5
        departureDayTextField.layer.masksToBounds = true
        departureDayTextField.textAlignment = .center
        departureDayTextField.attributedPlaceholder = NSAttributedString(
            string: "Departure date",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        departureDayTextField.font = UIFont(name: "Leto Text Sans Defect", size: 20)
        departureDayTextField.textColor = .black
        departureDayTextField.setInputView(target: self, selector: #selector(saveDepartureDate))
        
        starImage.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        
        ratingLabel.backgroundColor = .clear
        ratingLabel.textColor = .black
        ratingLabel.text = "5"
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont(name: "Leto Text Sans Defect", size: 25)
        
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        minusButton.backgroundColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1.0)
        minusButton.layer.cornerRadius = 12.5
        minusButton.layer.masksToBounds = true
        minusButton.titleLabel?.font = .systemFont(ofSize: 30)
        minusButton.addTarget(self, action: #selector(ratingDown), for: .touchUpInside)
        
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        plusButton.backgroundColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1.0)
        plusButton.layer.cornerRadius = 12.5
        plusButton.layer.masksToBounds = true
        plusButton.titleLabel?.font = .systemFont(ofSize: 30)
        plusButton.addTarget(self, action: #selector(ratingUp), for: .touchUpInside)
        
        addPhotosButton.setTitle("Add photos", for: .normal)
        addPhotosButton.layer.cornerRadius = 17
        addPhotosButton.backgroundColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1.0)
        addPhotosButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addPhotosButton.titleLabel?.font = UIFont(name: "Leto Text Sans Defect", size: 25)
        addPhotosButton.addTarget(self, action: #selector(addPhotos), for: .touchUpInside)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1.0)
        saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveButton.titleLabel?.font = UIFont(name: "Leto Text Sans Defect", size: 40)
        saveButton.addTarget(self, action: #selector(savePlaceInfo), for: .touchUpInside)
    }
    
    //    Parsing Countries with Flags
    
    private func setupCountry(){
        for code in NSLocale.isoCountryCodes  {
            let flag = String.emojiFlag(for: code)
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            if let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) {
                countriesData.append((name: name, flag: flag!))
                countriesData.sort(by: { $0.name < $1.name })
            } else { }
        }
    }
    
    //    Keyboard Setups
    
    private func keyboardForDescriptionTextView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //    Coding Images to CoreData
    
    func coreDataObjectFromImages(images: [UIImage]) -> Data? {
        let dataArray = NSMutableArray()
        for image in images {
            if let data = image.pngData() {
                dataArray.add(data)
            }
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }
    
    // MARK: - Helpers
    
    @objc private func setMoviePic() {
        showImagePickerControllerActionSheet()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.view.frame.origin.y -= 0.05 * keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc private func saveArrivalDate() {
        if let datePicker = arrivalDayTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd.MM.yyyy"
            arrivalDayTextField.text = dateFormatter.string(from: datePicker.date)
            firstDay = datePicker.date
        }
        arrivalDayTextField.resignFirstResponder()
    }
    
    @objc private func saveDepartureDate() {
        if let datePicker = departureDayTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd.MM.yyyy"
            departureDayTextField.text = dateFormatter.string(from: datePicker.date)
            secondDay = datePicker.date
        }
        departureDayTextField.resignFirstResponder()
    }
    
    //    Selecting a rating
    
    @objc func ratingUp() {
        if selectedRating < 5 {
            selectedRating += 1
        }
        ratingLabel.text = "\(selectedRating)"
    }
    @objc func ratingDown() {
        if selectedRating > 1 {
            selectedRating -= 1
        }
        ratingLabel.text = "\(selectedRating)"
    }
    
    @objc func addPhotos() {
        let vc = CollectionOfPhotosViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func savePlaceInfo() -> UIAlertController {
        let alert = UIAlertController(
            title: "Error", message: "The day of departure must be later than the day of arrival!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        if firstDay > secondDay {
            present(alert, animated: true, completion: nil)
            return  alert
        } else {
            let flagUnicode = flagLabel.text ?? ""
            let country = countryTextField.text ?? ""
            let city = cityTextField.text ?? ""
            let placeAvatar = placeAvatar
            let arrivalDay = arrivalDayTextField.text ?? ""
            let departureDay = departureDayTextField.text ?? ""
            let countOfDaysStaying = "\(firstDay.days(to: secondDay))"
            let placeRating = ratingLabel.text ?? ""
            let placeLatitude = 0.0
            let placeLongitude = 0.0
            arrayOfPhoto.append(placeAvatar)
            var arrayOfImages = [UIImage]()
            for image in arrayOfPhoto {
                if let addingImage = image.image {
                    arrayOfImages.append(addingImage)
                }
            }
            let collectionOfPhoto = coreDataObjectFromImages(images: arrayOfImages)
            let addingPlace = Place(flagUnicode: flagUnicode,
                                    country: country,
                                    city: city,
                                    placeAvatar: (placeAvatar.image?.pngData()!)!,
                                    arrivalDay: arrivalDay,
                                    departureDay: departureDay,
                                    countOfDaysStaying: countOfDaysStaying,
                                    placeRating: placeRating,
                                    placeLatitude: placeLatitude,
                                    placeLongitude: placeLongitude,
                                    collectionOfPhoto: collectionOfPhoto!
            )
            CoreDataManager.instance.savePlace(addingPlace)
            navigationController?.popViewController(animated: true)
            return alert
        }
    }
}

//MARK: Extensions

extension AddNewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    func showImagePickerControllerActionSheet() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.showImagePickerController(sourceType: .photoLibrary)
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.showImagePickerController(sourceType: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            placeAvatar.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            placeAvatar.image = originalImage
        }
        pickerImageView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = countriesData[row].name
        flagLabel.text = countriesData[row].flag
    }
}

//Count Of Days Staying

extension Date {
    func days(to secondDate: Date, calendar: Calendar = Calendar.current) -> Int {
        return calendar.dateComponents([.day], from: self, to: secondDate).day!
    }
}

extension AddNewPlaceViewController: TransferDataBetweenVCDelegats {
    func transferPhoto(_ photo: [UIImageView]) {
        arrayOfPhoto = photo
    }
}
