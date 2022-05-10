//
//  TodosViewController.swift
//  Test technique app
//
//  Created by macbook pro on 10/5/2022.
//

import UIKit

class TodosViewController: UIViewController {

    
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(TodosTableViewCell.self, forCellReuseIdentifier:TodosTableViewCell.identifier)
     return table
     }()
    
    
     var tasksArray = [TodosTableViewCellViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchTasks()
    }
    
    
    
    func fetchTasks() {
        let userID =  UsersViewController.id
        
        ApiCaller.shared.getUserTasks(id: userID) { [weak self] result in
            switch result {
            case.success(let todos):
                self?.tasksArray = todos.compactMap({
                    TodosTableViewCellViewModel(title: $0.title, completed: $0.completed)
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
     

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}

extension TodosViewController : UITableViewDelegate,UITableViewDataSource {
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier:TodosTableViewCell.identifier, for: indexPath) as? TodosTableViewCell  else {
        
        fatalError()
    }
    
    cell.configure(with: tasksArray[indexPath.row])
    
    return cell
}

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
}


