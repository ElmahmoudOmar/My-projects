//
//  TodosTableViewCell.swift
//  Test technique app
//
//  Created by macbook pro on 10/5/2022.
//

import UIKit

class TodosTableViewCell: UITableViewCell {

    static let identifier = "TodosTableViewCell"

    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    private let completedLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(completedLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
         titleLabelConstraints()
         completedLabelConstraints()
    }
    
    
    
    
    
    func titleLabelConstraints () {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func completedLabelConstraints () {
        completedLabel.translatesAutoresizingMaskIntoConstraints = false
        completedLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        completedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    
    
    func configure(with viewModel:TodosTableViewCellViewModel) {
        
        titleLabel.text = viewModel.title
        completedLabel.text = "Completed: \(viewModel.completed)"
    }
    
}
