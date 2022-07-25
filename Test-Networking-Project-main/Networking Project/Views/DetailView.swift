//
//  DetailView.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import UIKit

class DetailView: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    var arrayOfMeals : [DessertDetail] = []
    var router = Router<MealAPI>()
    var networking = NetworkManager()
    var mealID : String = ""
    
    let padding : CGFloat = 20
    let paddingTwoX : CGFloat = 20 * 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pulldata()
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    let dessertTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dessertImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.width)
        return image
    }()
    
    let instructionsTitle: UILabel = {
        let label = UILabel()
        label.text = "Loading one moment..."
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ingredientsTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let measurementsTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let measurementsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func setupViews(){
        setUpDeserTitleUI()
        setupImageUI()
        setUpInstructions()
        setUpIngredientsUI()
        setUpMeasureMentUI()
    }
    
    func setUpDeserTitleUI() {
        contentView.addSubview(dessertTitle)
        dessertTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dessertTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20 ).isActive = true
        dessertTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40 ).isActive = true
        dessertTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setupImageUI() {
        contentView.addSubview(dessertImage)
        dessertImage.translatesAutoresizingMaskIntoConstraints = false
        dessertImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dessertImage.topAnchor.constraint(equalTo: dessertTitle.bottomAnchor, constant: padding).isActive = true
        dessertImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        dessertImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        dessertImage.showLoading(style: .medium)
    }
    
    func setUpInstructions() {
        contentView.addSubview(instructionsTitle)
        instructionsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        instructionsTitle.topAnchor.constraint(equalTo: dessertImage.bottomAnchor, constant: padding).isActive = true
        instructionsTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        
        contentView.addSubview(instructionsLabel)
        instructionsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        instructionsLabel.topAnchor.constraint(equalTo: instructionsTitle.bottomAnchor, constant: padding).isActive = true
        instructionsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
    }
    
    func setUpIngredientsUI() {
        contentView.addSubview(ingredientsTitle)
        ingredientsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ingredientsTitle.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: padding).isActive = true
        ingredientsTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        
        contentView.addSubview(ingredientsLabel)
        ingredientsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: ingredientsTitle.bottomAnchor, constant: padding).isActive = true
        ingredientsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        
    }
    
    func setUpMeasureMentUI() {
        contentView.addSubview(measurementsTitle)
        measurementsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        measurementsTitle.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: padding).isActive = true
        measurementsTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        
        contentView.addSubview(measurementsLabel)
        measurementsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        measurementsLabel.topAnchor.constraint(equalTo: measurementsTitle.bottomAnchor, constant: padding).isActive = true
        measurementsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -paddingTwoX).isActive = true
        measurementsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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

// Networking And Data Request
extension DetailView {
    func pulldata() {
        networking.getDessertsDetails(mealID: self.mealID, completion: {  dessert, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.dessertImage.stopLoading()
                        self.dessertImage.isHidden = true
                        self.instructionsTitle.isHidden = true
                        self.setUptErrorLabel(errorText : error)
                    }
                }
                if let dessertDetails = dessert {
                    DispatchQueue.main.async {
                        //code that caused error goes here
                        UIView.transition(
                            with: self.contentView,
                            duration: 0.3,
                            options: .transitionCrossDissolve,
                            animations: {
                                let detailData = dessertDetails[0]
                                self.instructionsTitle.text = "Instructions"
                                
                                if let mealTitle = detailData.strMeal {
                                    self.dessertTitle.text = mealTitle
                                }
                                if let instructions = detailData.strInstructions {
                                    self.instructionsLabel.text = instructions
                                }
                                if let imageUrl = detailData.strMealThumb {
                                    self.dessertImage.kf.setImage(with: URL(string: imageUrl))
                                    self.dessertImage.stopLoading()
                                }
                                
                                if let ingredients = detailData.ingredients {
                                    self.ingredientsTitle.text = "Ingredients : "
                                    self.addList(.ingredientsList, listData: ingredients)
                                }
                                
                                if let measurement = detailData.measurement {
                                    self.measurementsTitle.text = "Measurements : "
                                    self.addList(.measurementsList, listData: measurement )
                                }
                            })
                    }
                }
            })
    }
}

// Creating Bullet Point List
extension DetailView {
    
    enum DetailListType {
        case ingredientsList
        case measurementsList
    }
    
    func addList(_ listType : DetailListType, listData : [String]) {

        let bullet = "•  "
        
        let list = listData.map { return bullet + $0 }
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.gray
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = list.joined(separator: "\n\n")
        switch listType {
        case .ingredientsList:
            ingredientsLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
        case .measurementsList:
            measurementsLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
        }
    }

}
