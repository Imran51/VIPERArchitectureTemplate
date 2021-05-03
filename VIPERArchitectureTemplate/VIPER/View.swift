//
//  View.swift
//  VIPERArchitectureTemplate
//
//  Created by Imran Sayeed on 12/4/21.
//

import Foundation
import UIKit

// ViewController
// Protocol
// reference presenter

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with users: [User])
    
    func update(with error: String)
}
 
class UserViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    private var users = [User]()
    
    private let tableview: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.isHidden = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        view.addSubview(label)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableview.frame = view.bounds
        label.frame = CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: 50)
    }
    
    func update(with users: [User]){
        DispatchQueue.main.async {[weak self] in
            self?.users = users
            print(users)
            self?.tableview.reloadData()
            self?.tableview.isHidden = false
            self?.label.isHidden = true
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {[weak self] in
            self?.users = []
            self?.tableview.isHidden = true
            self?.label.text = error
            self?.label.isHidden = false
        }
    }
}


extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
