import UIKit
import CoreLocation

final class TableViewCell: UITableViewCell {
    
    // MARK: Private
    
    private let backgroundTableView = UIView()
    private let avatarImage = UIImageView()
    private let whiteSquare = UIView()
    private let ratingLabel = UILabel()
    private let countryNameLabel = UILabel()
    private let flagLabel = UILabel()
    private let cityNameLabel = UILabel()
    private var arrivalDayLabel = UILabel()
    private var departureDayLabel = UILabel()
    private let calendarImage = UIImageView()
    private let countOfDaysLabel = UILabel()
   
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API

    func set(place: Place) {
        avatarImage.image = UIImage(data: place.placeAvatar)
        ratingLabel.text = "\u{2B50} \(place.placeRating)"
        countryNameLabel.text = place.country
        cityNameLabel.text = place.city
        flagLabel.text = place.flagUnicode
        arrivalDayLabel.text = "arr.day: \(place.arrivalDay)"
        departureDayLabel.text = "dep.day: \(place.departureDay)"
        countOfDaysLabel.text = "\(place.countOfDaysStaying) d"
    }

    // MARK: - Setups

    private func addSubviews() {
        contentView.addSubview(backgroundTableView)
        backgroundTableView.addSubview(avatarImage)
        backgroundTableView.addSubview(whiteSquare)
        backgroundTableView.addSubview(ratingLabel)
        backgroundTableView.addSubview(countryNameLabel)
        backgroundTableView.addSubview(flagLabel)
        backgroundTableView.addSubview(cityNameLabel)
        backgroundTableView.addSubview(arrivalDayLabel)
        backgroundTableView.addSubview(departureDayLabel)
        backgroundTableView.addSubview(calendarImage)
        backgroundTableView.addSubview(countOfDaysLabel)
    }

    private func setupConstraints() {
        backgroundTableView.translatesAutoresizingMaskIntoConstraints = false
        backgroundTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        backgroundTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        backgroundTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        backgroundTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        backgroundTableView.heightAnchor.constraint(equalToConstant: 210).isActive = true

        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: 0).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: backgroundTableView.bottomAnchor, constant: 0).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: backgroundTableView.leadingAnchor, constant: 0).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 180).isActive = true

        whiteSquare.translatesAutoresizingMaskIntoConstraints = false
        whiteSquare.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: 0).isActive = true
        whiteSquare.bottomAnchor.constraint(equalTo: backgroundTableView.bottomAnchor, constant: 0).isActive = true
        whiteSquare.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: -10).isActive = true
        whiteSquare.trailingAnchor.constraint(equalTo: backgroundTableView.trailingAnchor, constant: 0).isActive = true

        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 10).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: 10).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        flagLabel.translatesAutoresizingMaskIntoConstraints = false
        flagLabel.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: 15).isActive = true
        flagLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        flagLabel.trailingAnchor.constraint(equalTo: backgroundTableView.trailingAnchor, constant: -15).isActive = true
        flagLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.topAnchor.constraint(equalTo: backgroundTableView.topAnchor, constant: 15).isActive = true
        countryNameLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        countryNameLabel.leadingAnchor.constraint(equalTo: whiteSquare.leadingAnchor, constant: 15).isActive = true
        countryNameLabel.trailingAnchor.constraint(equalTo: flagLabel.leadingAnchor, constant: -15).isActive = true

        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 10).isActive = true
        cityNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cityNameLabel.leadingAnchor.constraint(equalTo: whiteSquare.leadingAnchor, constant: 15).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo: flagLabel.leadingAnchor, constant: -15).isActive = true

        calendarImage.translatesAutoresizingMaskIntoConstraints = false
        calendarImage.bottomAnchor.constraint(equalTo: backgroundTableView.bottomAnchor, constant: -25).isActive = true
        calendarImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        calendarImage.trailingAnchor.constraint(equalTo: backgroundTableView.trailingAnchor, constant: -15).isActive = true
        calendarImage.widthAnchor.constraint(equalToConstant: 70).isActive = true

        countOfDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        countOfDaysLabel.topAnchor.constraint(equalTo: calendarImage.topAnchor, constant: 25).isActive = true
        countOfDaysLabel.bottomAnchor.constraint(equalTo: calendarImage.bottomAnchor, constant: -15).isActive = true
        countOfDaysLabel.trailingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: -15).isActive = true
        countOfDaysLabel.leadingAnchor.constraint(equalTo: calendarImage.leadingAnchor, constant: 15).isActive = true

        departureDayLabel.translatesAutoresizingMaskIntoConstraints = false
        departureDayLabel.bottomAnchor.constraint(equalTo: backgroundTableView.bottomAnchor, constant: -25).isActive = true
        departureDayLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        departureDayLabel.leadingAnchor.constraint(equalTo: whiteSquare.leadingAnchor, constant: 15).isActive = true
        departureDayLabel.trailingAnchor.constraint(equalTo: calendarImage.leadingAnchor, constant: -15).isActive = true

        arrivalDayLabel.translatesAutoresizingMaskIntoConstraints = false
        arrivalDayLabel.bottomAnchor.constraint(equalTo: departureDayLabel.topAnchor, constant: -10).isActive = true
        arrivalDayLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        arrivalDayLabel.leadingAnchor.constraint(equalTo: whiteSquare.leadingAnchor, constant: 15).isActive = true
        arrivalDayLabel.trailingAnchor.constraint(equalTo: calendarImage.leadingAnchor, constant: -15).isActive = true
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)

        backgroundTableView.backgroundColor = .white
        backgroundTableView.layer.cornerRadius = 15
        backgroundTableView.layer.masksToBounds = true
        backgroundTableView.layer.shadowColor = UIColor.black.cgColor
        backgroundTableView.layer.shadowOpacity = 5
        backgroundTableView.layer.shadowRadius = 5
        
        avatarImage.layer.cornerRadius = 15
        avatarImage.layer.masksToBounds = true
        avatarImage.contentMode = .scaleToFill

        whiteSquare.backgroundColor = .white

        flagLabel.backgroundColor = .white
        flagLabel.textColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        flagLabel.font = .systemFont(ofSize: 40)
        flagLabel.textAlignment = .center
        flagLabel.adjustsFontSizeToFitWidth = true

        countryNameLabel.backgroundColor = .white
        countryNameLabel.textColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        countryNameLabel.textAlignment = .left
        countryNameLabel.font = UIFont(name: "Leto Text Sans Defect", size: 30)
        countryNameLabel.adjustsFontSizeToFitWidth = true
        countryNameLabel.numberOfLines = 0
        
        cityNameLabel.backgroundColor = .white
        cityNameLabel.textColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        cityNameLabel.textAlignment = .left
        cityNameLabel.font = UIFont(name: "Leto Text Sans Defect", size: 25)
        cityNameLabel.adjustsFontSizeToFitWidth = true
        cityNameLabel.numberOfLines = 0
        
        ratingLabel.backgroundColor = .white
        ratingLabel.layer.cornerRadius = 5
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont(name: "Leto Text Sans Defect", size: 16)
        ratingLabel.adjustsFontSizeToFitWidth = true
        ratingLabel.numberOfLines = 0
        
        arrivalDayLabel.backgroundColor = .white
        arrivalDayLabel.textColor = .black
        arrivalDayLabel.textAlignment = .left
        arrivalDayLabel.font = UIFont(name: "Leto Text Sans Defect", size: 16)
        arrivalDayLabel.adjustsFontSizeToFitWidth = true

        departureDayLabel.backgroundColor = .white
        departureDayLabel.textColor = .black
        departureDayLabel.textAlignment = .left
        departureDayLabel.font = UIFont(name: "Leto Text Sans Defect", size: 16)
        departureDayLabel.adjustsFontSizeToFitWidth = true
        
        calendarImage.image = UIImage(systemName: "calendar")?.withTintColor(UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1), renderingMode: .alwaysOriginal)
        calendarImage.sizeToFit()
        
        countOfDaysLabel.backgroundColor = .white
        countOfDaysLabel.textColor = .black
        countOfDaysLabel.textAlignment = .center
        countOfDaysLabel.font = UIFont(name: "Leto Text Sans Defect", size: 40)
        countOfDaysLabel.adjustsFontSizeToFitWidth = true
    }
}
