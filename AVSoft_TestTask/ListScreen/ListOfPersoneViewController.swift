//
//  ViewController.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class ListOfPersoneViewController: UIViewController {
    
    private var cellID = "CellID"
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            ModelManager.shared.loadFromFile()
            self.tableView.reloadData()

        }
        setup()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setup() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension ListOfPersoneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelManager.shared.personesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ListOfPersoneTableViewCell()
        cell.persone = ModelManager.shared.personesArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let persone = ModelManager.shared.personesArray?[indexPath.row]
        let editVC = tabBarController?.viewControllers?[0] as? EditViewController
        editVC?.persone = persone
        
        UIView.transition(from: self.view, to: editVC!.view, duration: 0.3, options: [.transitionFlipFromBottom]) { (_) in
            self.tabBarController?.selectedIndex = 0
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            ModelManager.shared.personesArray?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            DispatchQueue.global().async {
                ModelManager.shared.startSaving()
            }
        }
    }
}

