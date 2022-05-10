//
//  ViewController.swift
//  Test technique app
//
//  Created by macbook pro on 9/5/2022.
//

import UIKit

class UsersViewController: UIViewController {

    private let tableView:UITableView = {
        let table = UITableView()
        table.register(UsersTableViewCell.self, forCellReuseIdentifier:UsersTableViewCell.identifier)
     return table
     }()
    
    
    var usersArray = [UsersTableViewCellViewModel]()
    var users = [User]()
    static var id = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Users"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


    func fetchData(){
        ApiCaller.shared.getUsers { [weak self] result in
            switch result {
            case.success(let users):
                self?.users = users
                self?.usersArray = users.compactMap({
                    UsersTableViewCellViewModel(id: $0.id ?? 0, name: $0.name ?? "No name", username: $0.username ?? "No username", email: $0.email ?? "No email")
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
}



extension UsersViewController : UITableViewDelegate,UITableViewDataSource {
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usersArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier:UsersTableViewCell.identifier, for: indexPath) as? UsersTableViewCell  else {
        
        fatalError()
    }
    
    cell.configure(with: usersArray[indexPath.row])
    
    return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userID =  users[indexPath.row].id ?? 0
        UsersViewController.id = userID
        let secondVC = TodosViewController()
        self.present(secondVC, animated: true, completion: nil)
}

}
