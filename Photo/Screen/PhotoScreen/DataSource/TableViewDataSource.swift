//
//  PhotoDataSource.swift
//  Photo
//
//  Created by Александр Басов on 12/30/21.
//

import UIKit
import Firebase

class TableViewDataSource: NSObject {
    
    // - CollectionView
    private var tableView: UITableView
    
    // - ViewModel
    private var viewModel: PhotoViewModel
    
    // - Delegate
    weak var delegate: PhotoDelegate?
    
    // - Firebase
    private let storage = Storage.storage().reference()
    
    init(tableView: UITableView, viewModel: PhotoViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()
        configure()
    }
}

//MARK: - UITableViewDataSource
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.reuseID, for: indexPath) as! FirstTableViewCell
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.reuseID, for: indexPath) as! SecondTableViewCell
        cell.delegate = delegate
        cell.configureCell(images: viewModel.images)
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension TableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        if indexPath.row != 0 {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                self.storage.child("images").listAll { (result, error) in
                    result.items.forEach { (imageRef) in
                        imageRef.delete { error in
                            if let error = error {
                                print(error)
                            } else {
                                print("Delete")
                            }
                        }
                    }
                }
                tableView.deleteRows(at: [indexPath], with: .none)
                tableView.reloadData()
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = #colorLiteral(red: 0.7288427982, green: 0.3635109873, blue: 0.3498608176, alpha: 1)
            deleteAction.title = "Удалить"
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
        return nil
    }
}

//MARK: - Configure
private extension TableViewDataSource {
    
    func configure() {
        registerCells()
        setupDataSource()
    }
    
    func setupDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(FirstTableViewCell.nib(), forCellReuseIdentifier: FirstTableViewCell.reuseID)
        tableView.register(SecondTableViewCell.nib(), forCellReuseIdentifier: SecondTableViewCell.reuseID)
    }
    
}
