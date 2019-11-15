//
//  AboutViewController.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    private var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    private func setup() {
        view.backgroundColor = .white
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        let normalFont = UIFont(name: "AvenirNext-Italic", size: 15)
        let boldFont = UIFont(name: "AvenirNext-BoldItalic", size: 15)
        
        label.textAlignment = .center
        label.attributedText = addBoldText(
            fullString: "Тестовое задание для \n AVSoft ",
            boldPartOfString: "AVSoft",
            font: normalFont,
            boldFont: boldFont
        )
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    private  func addBoldText(fullString: NSString, boldPartOfString: NSString, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString as String))
        return boldString
    }
    
}
