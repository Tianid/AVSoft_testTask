//
//  EditPrimaryAttributeTableViewCell.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 14.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class EditPrimaryAttributeTableViewCell: UITableViewCell {
    
    
    var name: String? {
        get {
            return nameTextField.text
        }
        
        set {
            nameTextField.text = newValue
        }
    }
    
    var secondName: String? {
        get {
            return secondTextField.text
        }
        
        set {
            secondTextField.text = newValue
        }
    }
    
    var lastName: String? {
        get {
            return lastTextField.text
        }
        
        set {
            lastTextField.text = newValue
        }
    }
    
    
    private var nameLabel: UILabel!
    private var secondNameLabel: UILabel!
    private var lastNameLabel: UILabel!
    
    private var nameTextField: UITextField!
    private var secondTextField: UITextField!
    private var lastTextField: UITextField!

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
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetFields() {
        nameTextField.text = nil
        secondTextField.text = nil
        lastTextField.text = nil
    }
    
    
    private func setup() {
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        secondNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        lastNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        
        nameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        secondTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        lastTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        lastTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.autocapitalizationType = .none
        secondTextField.autocapitalizationType = .none
        lastTextField.autocapitalizationType = .none
        
        nameLabel.text = "Имя"
        secondNameLabel.text = "Фамилия"
        lastNameLabel.text = "Отчество"
        
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.cornerRadius = 4
        secondTextField.layer.borderWidth = 0.5
        secondTextField.layer.cornerRadius = 4
        lastTextField.layer.borderWidth = 0.5
        lastTextField.layer.cornerRadius = 4
        
        addSubview(nameLabel)
        addSubview(secondNameLabel)
        addSubview(lastNameLabel)
        
        addSubview(nameTextField)
        addSubview(secondTextField)
        addSubview(lastTextField)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            secondNameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            secondNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
              
        NSLayoutConstraint.activate([
            secondTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 8),
            secondTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            secondTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 8),
            lastNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            lastTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            lastTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        
        let labelsHeight = nameLabel.frame.size.height + secondNameLabel.frame.size.height + lastNameLabel.frame.size.height
        let textFieldsHeigth = nameTextField.frame.size.height + secondTextField.frame.size.height + lastTextField.frame.size.height
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: labelsHeight + textFieldsHeigth )
        ])
    }
    
}
