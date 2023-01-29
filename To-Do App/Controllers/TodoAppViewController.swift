//
//  ViewController.swift
//  To-do
//
//  Created by macbook pro on 5/12/2022.
//

import UIKit
import RealmSwift
import DynamicColor

class TodoAppViewController: SwipeTableViewController {
    
    
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // This will change the navigation bar background and title color

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        if let stringColor = selectedCategory?.color {
            appearance.backgroundColor = DynamicColor(hexString: stringColor)
            let adaptiveColor = DynamicColor(hexString: stringColor).isDarkColor == true ? UIColor.white : UIColor.black
           let titleAttribute = [NSAttributedString.Key.foregroundColor:adaptiveColor]
           appearance.titleTextAttributes = titleAttribute
           appearance.largeTitleTextAttributes = titleAttribute
            title = selectedCategory!.name
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.tintColor = adaptiveColor
        }
        
    }
    
    
    

    //MARK: - Tableview Datasource  and Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            let colorString = item.color
            if DynamicColor(hexString: colorString).isDarkColor == true {
                cell.backgroundColor = DynamicColor(hexString: colorString).lighter(amount: CGFloat(indexPath.row)/CGFloat((toDoItems?.count ?? Int(0.2))+1))
            } else {
                cell.backgroundColor = DynamicColor(hexString: colorString).darkened(amount: CGFloat(indexPath.row)/CGFloat((toDoItems?.count ?? Int(0.2))+1))
            }
            cell.textLabel?.textColor = cell.backgroundColor?.isDarkColor == true ? .white : .black
            cell.textLabel?.font = .systemFont(ofSize: 17, weight: .medium)

        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write{
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
 
    //MARK: - Data Manipulation Methods

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To-do Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            guard let text = textField.text, !text.isEmpty else {

                let alert = UIAlertController(title: "OOPS!", message: "you pressed add without writing anything in the textfield", preferredStyle: .alert)
                let action = UIAlertAction(title: "cancel", style: .cancel)
                alert.addAction(action)
                self.present(alert, animated: true)
                return
            }
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        newItem.color = currentCategory.color
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: false)
        tableView.reloadData()
    }
    
    
    //MARK: - Delete Data From Swipe

    override func updateData(at indexPath: IndexPath) {
        
        if  let item = toDoItems?[indexPath.row] {
            
            do {
                try realm.write({
                    realm.delete(item)
                })
            } catch  {
                print("error deleting\(error)")
            }
        }
    }

}




//MARK: - UISearchbar Delegate Methods

extension TodoAppViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        guard let text = searchBar.text, !text.isEmpty else {

            let alert = UIAlertController(title: "Alert", message: "need to enter what you are looking for in the textfield", preferredStyle: .alert)
            let action = UIAlertAction(title: "cancel", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", text).sorted(byKeyPath: "dateCreated",ascending: false)
        tableView.reloadData()
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadItems()
        searchBar.text = ""
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
}
