//
//  EditViewController.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    private var isNeedLogin = true
    private var cellIdentifierForPrimary = "cell_id_1"
    private var cellIdentifierForSecondary = "cell_id_2"
    
    private var tableView: UITableView!
    private var navigationBar: UINavigationBar!
    
    private var primaryAttributes: EditPrimaryAttributeTableViewCell?
    
    var persone: Persone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isNeedLogin {
            isNeedLogin = false
            let loginVC = LoginViewController()
            present(loginVC,animated: true)
        }
     
        guard persone == nil else { tableView.reloadData(); return }
        persone = Persone(name: String(), secondName: String(), lastName: String())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        primaryAttributes?.resetFields()
        persone = nil
        tableView.reloadData()
    }
    
    private func setup() {
        navigationBar = UINavigationBar()
        navigationItem.setLeftBarButton(
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewAttribute)),
            animated: true)
        navigationItem.setRightBarButton(
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePersone)),
            animated: true)
        
        navigationBar.items?.append(self.navigationItem)
        navigationBar.barTintColor = #colorLiteral(red: 0.9370916486, green: 0.9369438291, blue: 0.9575446248, alpha: 1)
        navigationBar.layer.borderWidth = 0.5
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        
        tableView.register(EditSecondaryAttributeTableViewCell.self, forCellReuseIdentifier: cellIdentifierForSecondary)
        tableView.register(EditPrimaryAttributeTableViewCell.self, forCellReuseIdentifier: cellIdentifierForPrimary)
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createAlert() {
        let alert = UIAlertController(title: nil, message: "Заполните все основные атрибуты", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    @objc private func addNewAttribute() {
        let newAttribute = SecondaryAttributes(attributeName: String(), attributeValue: String())
        persone?.secondaryAttributes?.append(newAttribute)
        let indexPath = IndexPath(row: tableView.numberOfRows(inSection: 1), section: 1)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    @objc private func savePersone() {
        guard let name = primaryAttributes?.name, let secondName = primaryAttributes?.secondName, let lastName = primaryAttributes?.lastName else { return }
        guard !name.isEmpty, !secondName.isEmpty, !lastName.isEmpty else { createAlert(); return }

        persone?.primaryAttributes.name = name
        persone?.primaryAttributes.secondName = secondName
        persone?.primaryAttributes.lastName = lastName

        if !(ModelManager.shared.personesArray?.contains(where: { (persone) -> Bool in
            guard self.persone === persone else { return false }
            return true
        }))! {
            ModelManager.shared.personesArray?.append(persone!)
        }
        ModelManager.shared.startSaving()

        
        let listOfPersoneVC = tabBarController?.viewControllers?[1] as? ListOfPersoneViewController
        
        UIView.transition(from: self.view, to: listOfPersoneVC!.view, duration: 0.3, options: [.transitionFlipFromTop]) { (_) in
            self.tabBarController?.selectedIndex = 1
        }
    }
}


extension EditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierForSecondary, for: indexPath) as? EditSecondaryAttributeTableViewCell
            cell?.resetFields()
            cell?.personeDataAndIndex = .some((persone: persone!, index: indexPath.row))
            cell?.selectionStyle = .none
            return cell!
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierForPrimary, for: indexPath) as? EditPrimaryAttributeTableViewCell
            primaryAttributes = cell
            cell?.name = persone?.primaryAttributes.name
            cell?.secondName = persone?.primaryAttributes.secondName
            cell?.lastName = persone?.primaryAttributes.lastName
            cell?.selectionStyle = .none
            return cell!
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return persone?.secondaryAttributes?.count ?? 0 }
        return 1

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard section == 0 else { return "Дополнительные атрибуты" }
        return "Основные атрибуты"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.section == 1 else { return false }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete && indexPath.section == 1 else { return }
        persone?.secondaryAttributes?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

