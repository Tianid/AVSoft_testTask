//
//  ListOfPersoneTableViewCell.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 14.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class ListOfPersoneTableViewCell: UITableViewCell {
    
    private var nameCallLabel: UILabel!
    private var secondNameCallLabel: UILabel!
    private var lastNameCallLabel: UILabel!
    
    private var nameLabel: UILabel!
    private var secondNameLabel: UILabel!
    private var lastNameLabel: UILabel!
    
    private var dynamicUIElements: [UIView] = []
    
    var persone: Persone? {
        didSet {
            setup()
            setupDynamicUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        nameCallLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        secondNameCallLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        lastNameCallLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        
        nameCallLabel.text = "Имя"
        secondNameCallLabel.text = "Фамилия"
        lastNameCallLabel.text = "Отчество"
        
        nameCallLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        secondNameCallLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        lastNameCallLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        secondNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        lastNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        
        nameLabel.text = persone?.primaryAttributes.name
        secondNameLabel.text = persone?.primaryAttributes.secondName
        lastNameLabel.text = persone?.primaryAttributes.lastName
        
        nameCallLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNameCallLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameCallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameCallLabel)
        addSubview(secondNameCallLabel)
        addSubview(lastNameCallLabel)
        
        addSubview(nameLabel)
        addSubview(secondNameLabel)
        addSubview(lastNameLabel)
        
        NSLayoutConstraint.activate([
            nameCallLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameCallLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameCallLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            secondNameCallLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            secondNameCallLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            secondNameLabel.topAnchor.constraint(equalTo: secondNameCallLabel.bottomAnchor, constant: 8),
            secondNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            lastNameCallLabel.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 8),
            lastNameCallLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: lastNameCallLabel.bottomAnchor, constant: 8),
            lastNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
    }
    
    private func setupDynamicUI() {
        
        guard let persone = persone else { return }
        guard let secondsAttributes = persone.secondaryAttributes, secondsAttributes.count > 0 else {
            let height = getHeight()
            setHeightAnchor(height: height)
            return
        }
        var height: CGFloat = 0.0
        
        for (index, value) in secondsAttributes.enumerated() {
            
            let attributeNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            let attributeValueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            
            attributeNameLabel.translatesAutoresizingMaskIntoConstraints = false
            attributeValueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(attributeNameLabel)
            addSubview(attributeValueLabel)
            
            attributeNameLabel.text = value.attributeName
            attributeValueLabel.text = value.attributeValue
            
            attributeNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)

            
            if index == 0 {
                NSLayoutConstraint.activate([
                    attributeNameLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
                    attributeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
                ])
                
                NSLayoutConstraint.activate([
                    attributeValueLabel.topAnchor.constraint(equalTo: attributeNameLabel.bottomAnchor, constant: 8),
                    attributeValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
                ])
                
            } else {
                NSLayoutConstraint.activate([
                    attributeNameLabel.topAnchor.constraint(equalTo: dynamicUIElements[index - 1].bottomAnchor, constant: 8),
                    attributeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
                ])
                
                NSLayoutConstraint.activate([
                    attributeValueLabel.topAnchor.constraint(equalTo: attributeNameLabel.bottomAnchor, constant: 8),
                    attributeValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
                ])
            }
            
            dynamicUIElements.append(attributeValueLabel)
            
            height += attributeNameLabel.frame.size.height
            height += attributeValueLabel.frame.size.height
            
        }
        
        height += getHeight()
        setHeightAnchor(height: height)
    }
    
    private func setHeightAnchor(height: CGFloat) {
        let myHeightAnchor = heightAnchor.constraint(equalToConstant: height)
        myHeightAnchor.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            myHeightAnchor
        ])
    }
    
    private func getHeight() -> CGFloat{
        let callLabelsHeight = nameCallLabel.frame.size.height + secondNameCallLabel.frame.size.height + lastNameCallLabel.frame.size.height
        let labelsHeight = nameLabel.frame.size.height + secondNameLabel.frame.size.height + lastNameLabel.frame.size.height
        
        return callLabelsHeight + labelsHeight
    }
}

