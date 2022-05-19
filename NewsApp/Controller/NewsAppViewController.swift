//
//  ViewController.swift
//  NewsApp
//
//  Created by macbook pro on 7/4/2022.
//

import UIKit
import SafariServices

class NewsAppViewController: UIViewController {
    
    
   private let tableView:UITableView = {
        let table = UITableView()
    table.register(NewsTableViewCell.self, forCellReuseIdentifier:NewsTableViewCell.identifier)
    return table
    }()
    
    let searchVC = UISearchController(searchResultsController: nil)

    var articles = [Article]()
    var articlesArray = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "News"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchNews()
        searchBar()
      
    }
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func searchBar(){
        
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    
    
    func fetchNews(){
        APICaller.shared.getTopNews { [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.articlesArray = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title ?? "No Title", subTitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
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
    
extension NewsAppViewController : UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell  else {
            
            fatalError()
        }
        
        cell.configure(with: articlesArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard  let text = searchBar.text, !text.isEmpty else {
            return
        }
        APICaller.shared.serach(for: text) { [weak self] result in
            switch result {
            case.success(let articles):
                self?.articles = articles
                self?.articlesArray = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title ?? "No Title", subTitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
}

