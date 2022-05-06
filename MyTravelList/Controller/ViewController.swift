import UIKit
import CoreData
import CoreLocation

final class ViewController: UIViewController {
    
    // MARK: Private
    
    private var tableView = UITableView()
    private let helpWindowView = UIImageView()
    private var topConstraints = NSLayoutConstraint()
    private var visitedPlaces = [Place]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(helpWindowView)
        setupTableView()
        addConstraints()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let places = CoreDataManager.instance.getPlace() else { return }
        visitedPlaces = places
        setupForHelpWindow()
    }
    
    // MARK: - Setups
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        helpWindowView.translatesAutoresizingMaskIntoConstraints = false
        helpWindowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        helpWindowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        helpWindowView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        topConstraints = helpWindowView.topAnchor.constraint(equalTo: view.topAnchor, constant: -300)
        topConstraints.isActive = true
    }
    
    private func setupUI() {
        title = "My Travel List"
        navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Leto Text Sans Defect", size: 30)!
        ]
        
        navigationItem.leftBarButtonItem  = UIBarButtonItem(
            image: UIImage(systemName: "map.circle"),
            style: .plain, target: self,
            action: #selector(addInfoToTheMap)
        )
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: .plain, target: self,
            action: #selector(addNewPlace)
        )
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.backBarButtonItem?.tintColor = .white
        
        view.backgroundColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        
        tableView.backgroundColor = UIColor(red: 25/255, green: 64/255, blue: 160/255, alpha: 1)
        
        helpWindowView.image = UIImage(named: "tip.png")
        helpWindowView.layer.cornerRadius = 15
        helpWindowView.layer.masksToBounds = true
        helpWindowView.layer.shadowColor = UIColor.white.cgColor
        helpWindowView.layer.shadowRadius = 5
        helpWindowView.layer.shadowOpacity = 0.7
    }
    
    private func setupForHelpWindow() {
        if visitedPlaces.isEmpty {
            topConstraints.constant = 100
            self.view.layoutIfNeeded()
            helpWindowView.alpha = 0
            UIView.animate(withDuration: 2.5) {
                self.helpWindowView.alpha = 1
            }
        }
        else {
            topConstraints.constant = -300
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Helpers
    
    @objc private func addInfoToTheMap() {
        let vc = MapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addNewPlace() {
        let vc = AddNewPlaceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

    // MARK: - Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            cell.set(place: visitedPlaces[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.instance.deleteEntity(placesArray: visitedPlaces, indexPath: indexPath)
            visitedPlaces.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.set(place: visitedPlaces[indexPath.row])
    }
}
