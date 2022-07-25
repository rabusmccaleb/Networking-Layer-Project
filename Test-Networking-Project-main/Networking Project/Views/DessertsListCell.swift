//
//  DessertsListCell.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.

import UIKit
import Kingfisher

class DessertsListCell: UITableViewCell {
    
    static let identifier = "DessertsListCell"

    lazy var thumbnail : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var dessertLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnail)
        addSubview(dessertLabel)
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: topAnchor),
            thumbnail.bottomAnchor.constraint(equalTo: bottomAnchor),
            thumbnail.rightAnchor.constraint(equalTo: rightAnchor),
            thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor),
            
            dessertLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dessertLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            dessertLabel.rightAnchor.constraint(equalTo: thumbnail.leftAnchor)
        ])
    }
    
    func setupCell(imageURL: String) {
        thumbnail.kf.setImage(with:  URL(string: imageURL))
    }
    
    func setupDessertLabel(textString: String) {
        dessertLabel.text = textString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
