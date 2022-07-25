//
//  ViewController.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/9/22.
//

import UIKit

class ViewController: UIViewController {
    var arrayOfMeals : [Meal] = []
    var router = Router<MealAPI>()
    var networking = NetworkManager()
    
    lazy var mealTableView: UITableView = {
        var tableView = UITableView()
        // styling logic
        return tableView
    }()
    
    lazy var laodingView : UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavStyling()
        view.addSubview(mealTableView)
        mealTableView.register(DessertsListCell.self, forCellReuseIdentifier: DessertsListCell.identifier)
        mealTableView.delegate = self
        mealTableView.dataSource = self
        pulldata()
        setUptLoadingIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mealTableView.frame = view.bounds
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func setupNavStyling() {
        navigationItem.title = "Fetch Rewards"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    
    func setUptLoadingIndicator() {
        view.addSubview(laodingView)
        laodingView.translatesAutoresizingMaskIntoConstraints = false
        laodingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        laodingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        laodingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        laodingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        laodingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        laodingView.showLoading(style: .medium)
    }
    
    func setUptErrorLabel(errorText : String) {
        view.addSubview(errorLabel)
        errorLabel.text = errorText
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

// TableView Setup
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrayOfMeals.count - 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealTableView.dequeueReusableCell(withIdentifier: DessertsListCell.identifier , for: indexPath) as! DessertsListCell
        if let cellTitle = arrayOfMeals[indexPath.row].strMeal {
            cell.setupDessertLabel(textString: cellTitle)
        }
        
        if let imageURL = arrayOfMeals[indexPath.row].strMealThumb  {
            cell.setupCell(imageURL: imageURL)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mealID = arrayOfMeals[indexPath.row].idMeal {
            let detailView = DetailView()
            detailView.view.backgroundColor = UIColor.systemBackground
            detailView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.bounds.height)
            detailView.mealID = mealID
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let cellHeight : CGFloat = CGFloat( tableView.bounds.height * 0.1 )

        return cellHeight
        
    }
}

// Networking And Data Request
extension ViewController {
    
    func pulldata() {
        networking.getDesserts(completion: { desserts, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.laodingView.stopLoading()
                    self.setUptErrorLabel(errorText : error)
                }
            }
            if let dessertsList = desserts {
                DispatchQueue.main.async {
                    self.arrayOfMeals = dessertsList
                    self.laodingView.stopLoading()
                    self.mealTableView.reloadData()
                }
            }
            
        })
    }
    
}
