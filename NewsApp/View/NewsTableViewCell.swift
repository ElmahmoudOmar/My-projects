//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by macbook pro on 8/4/2022.
//

import UIKit


class NewsTableViewCell: UITableViewCell {

   static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    private let newsSubTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    private let newsImageView:UIImageView = {
        let image = UIImageView()
        image.layer.backgroundColor = UIColor.clear.cgColor
        image.layer.backgroundColor = UIColor.clear.cgColor
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFill
        
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsSubTitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         newsTitleLabelConstraints()
         newsSubTitleLabelConstraints()
         newsImageViewConstraints()
    }
    

    func newsImageViewConstraints () {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.trailingAnchor.constraint(equalTo:contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        newsImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func newsTitleLabelConstraints () {
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        newsTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        newsTitleLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    func newsSubTitleLabelConstraints () {
        newsSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsSubTitleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        newsSubTitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10).isActive = true
        newsSubTitleLabel.widthAnchor.constraint(equalToConstant: 230).isActive = true
        newsSubTitleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func configure(with viewModel:NewsTableViewCellViewModel) {
        
        newsTitleLabel.text = viewModel.title
        newsSubTitleLabel.text = viewModel.subTitle
        
        if  let data = viewModel.imageDATA {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            
            URLSession.shared.dataTask(with: url) {(data, _, error) in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageDATA = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
  
        }
        
    }
    
}
