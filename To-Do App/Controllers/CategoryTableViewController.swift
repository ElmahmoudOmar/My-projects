//
//  CategoryTableViewController.swift
//  To-do
//
//  Created by macbook pro on 29/12/2022.
//

import UIKit
import RealmSwift
import DynamicColor


class CategoryTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.rowHeight = 70
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // This will change the navigation bar background and title color

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        let colorString = categories?[indexPath.row].color
        cell.backgroundColor = DynamicColor(hexString: colorString ?? "#FFFFFF")
        cell.textLabel?.textColor = cell.backgroundColor?.isDarkColor == true ? .white : .black
        cell.textLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        return cell
    }

    
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    //MARK: - Delete Data From Swipe
    
    override func updateData(at indexPath: IndexPath) {
        
        if  let category = categories?[indexPath.row] {
            
            do {
                try realm.write({
                    realm.delete(category)
                })
            } catch  {
                print("error deleting\(error)")
            }
        }
    }
    
    //MARK: - Add New Categories
    
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a New Cateogry", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let text = textField.text, !text.isEmpty else {

                let alert = UIAlertController(title: "OOPS!", message: "you pressed add without writing anything in the textfield", preferredStyle: .alert)
                let action = UIAlertAction(title: "cancel", style: .cancel)
                alert.addAction(action)
                self.present(alert, animated: true)
                return
            }
            let newCategory = Category()
            newCategory.name = textField.text!
            let colorString = UIColor.randomColor().toHexString()
            newCategory.color = colorString
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add category"
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoAppViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}

