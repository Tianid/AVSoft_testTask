//
//  EditVCTableViewCell.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class EditSecondaryAttributeTableViewCell: UITableViewCell {
    var personeDataAndIndex: (persone: Persone, index: Int)? {
        didSet {
            setValueForfields()
        }
    }
    private var attributeNameTextField: UITextField!
    private var attributeValueTextField: UITextField!

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
        attributeValueTextField.text = nil
        attributeNameTextField.text = nil
    }
    
    private func setValueForfields() {
        let index = (personeDataAndIndex?.index)!
        guard let secondAttributes = personeDataAndIndex?.persone.secondaryAttributes else { return }
        let attributeName = secondAttributes[index].attributeName
        let attributeValue = secondAttributes[index].attributeValue
        
        attributeNameTextField.text = attributeName
        attributeValueTextField.text = attributeValue
    }
    
    private func setup() {
        attributeNameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        attributeValueTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
                
        attributeNameTextField.placeholder = "Имя атрибута"
        attributeValueTextField.placeholder = "Значение атрибута"
        attributeNameTextField.autocapitalizationType = .none
        attributeValueTextField.autocapitalizationType = .none
        
        attributeNameTextField.layer.borderWidth = 0.5
        attributeNameTextField.layer.cornerRadius = 4
        attributeValueTextField.layer.borderWidth = 0.5
        attributeValueTextField.layer.cornerRadius = 4
        
        attributeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        attributeValueTextField.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(attributeNameTextField)
        addSubview(attributeValueTextField)
        
        NSLayoutConstraint.activate([
            attributeNameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            attributeNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            attributeNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

        ])
        
        let anchor = attributeValueTextField.topAnchor.constraint(equalTo: attributeNameTextField.bottomAnchor, constant: 8)
        anchor.priority = UILayoutPriority(750)
        
        NSLayoutConstraint.activate([
            anchor,
            attributeValueTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            attributeValueTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            attributeValueTextField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8)
            ])
        
        attributeValueTextField.addTarget(self,
                                          action: #selector(setPersoneWithTextFieldData(textField:)),
                                          for: .editingChanged)
        attributeNameTextField.addTarget(self,
                                         action: #selector(setPersoneWithTextFieldData(textField: )),
                                         for: .editingChanged)
    }
    
    @objc private func setPersoneWithTextFieldData(textField: UITextField) {
        let persone = personeDataAndIndex?.persone
        let index = (personeDataAndIndex?.index)!
        
        switch textField {
        case attributeNameTextField:
            persone?.secondaryAttributes?[index].attributeName = textField.text!
        case attributeValueTextField:
            persone?.secondaryAttributes?[index].attributeValue = textField.text!
        default:
            break
        }
    }
}

