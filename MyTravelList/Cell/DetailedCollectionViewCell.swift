import UIKit

class DetailedCollectionViewCell: UICollectionViewCell {
    
    // MARK: Private

     private let cellView = UIView()
     private let photoImageView = UIImageView()

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubviews()
        setupConstraints()
        setupUI()
    }
    
    // MARK: - API

    func setPhoto(photo: UIImage) {
        photoImageView.image = photo
    }

    // MARK: - Setups

    private func addSubviews() {
        contentView.addSubview(cellView)
        cellView.addSubview(photoImageView)
    }

    private func setupConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 5).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 5).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -5).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -5).isActive = true
    }

    private func setupUI() {
        cellView.backgroundColor =  UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = true
        cellView.layer.borderColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1.0).cgColor
        cellView.layer.borderWidth = 2
        
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.masksToBounds = true
        photoImageView.contentMode = .scaleAspectFill
    }
}
