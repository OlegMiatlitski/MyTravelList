import UIKit

final class CollectionOfPhotosViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Private
    
    private let backgroundRectangle = UIView()
    private let addANewPhotoButton = UIButton()
    private let pickerImageView = UIImageView()
    private let saveButton = UIButton()
    private let layout = UICollectionViewFlowLayout()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    private var arrayOfAddedPhotos: [UIImageView] = []{
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: TransferDataBetweenVCDelegats?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setupCollectionView()
        setupUI()
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        view.addSubview(backgroundRectangle)
        view.addSubview(pickerImageView)
        view.addSubview(addANewPhotoButton)
        view.addSubview(saveButton)
        view.addSubview(collectionView)
    }
   
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AddingPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddingPhotoCollectionViewCell")
        collectionView.collectionViewLayout = layout
        layout.itemSize = CGSize(width: 160, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
    }
    
    private func addConstraints() {
        
        backgroundRectangle.translatesAutoresizingMaskIntoConstraints = false
        backgroundRectangle.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        pickerImageView.translatesAutoresizingMaskIntoConstraints = false
        pickerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        pickerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pickerImageView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        pickerImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        addANewPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        addANewPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        addANewPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        addANewPhotoButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        addANewPhotoButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: addANewPhotoButton.bottomAnchor, constant: 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 230).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupUI(){
                        
        let image = UIImageView()
        image.image = UIImage(named: "background")!
        image.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(patternImage: image.image!)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        collectionView.backgroundColor = .clear
        
        backgroundRectangle.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        addANewPhotoButton.setTitle("Add a new photo", for: .normal)
        addANewPhotoButton.layer.cornerRadius = 17
        addANewPhotoButton.backgroundColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1.0)
        addANewPhotoButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addANewPhotoButton.titleLabel?.font = UIFont(name: "Leto Text Sans Defect", size: 25)
        addANewPhotoButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        
        saveButton.setTitle("Save photos", for: .normal)
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = UIColor(red: 79/255, green: 143/255, blue: 0/255, alpha: 1.0)
        saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveButton.titleLabel?.font = UIFont(name: "Leto Text Sans Defect", size: 30)
        saveButton.addTarget(self, action: #selector(savePhotoCollection), for: .touchUpInside)
    }

    // MARK: - Helpers
    
    @objc private func saveImage() {
        showImagePickerControllerActionSheet()
    }
    
    @objc func savePhotoCollection() {
        delegate?.transferPhoto(arrayOfAddedPhotos)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions

extension CollectionOfPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfAddedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddingPhotoCollectionViewCell", for: indexPath) as? AddingPhotoCollectionViewCell {
            cell.setPhoto(photo: arrayOfAddedPhotos[indexPath.row].image!)
        return cell
        }
        return UICollectionViewCell()
}

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
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
       if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
           arrayOfAddedPhotos.append(UIImageView(image: editedImage))
       } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           arrayOfAddedPhotos.append(UIImageView(image: originalImage))
        }
        pickerImageView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}
