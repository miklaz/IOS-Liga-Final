//
//  HistoryTableVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 14.04.2022.
//

import UIKit
import CoreData

final class HistoryTableVC: UIViewController {
    
    var history: [NSManagedObject] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

// MARK: - VC Live Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAttributeAlert))
        let clearBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAllAttributesAlert))
        addBarButtonItem.tintColor = .systemBlue
        clearBarButtonItem.tintColor = .systemRed
        navigationItem.rightBarButtonItem  = addBarButtonItem
        navigationItem.leftBarButtonItem = clearBarButtonItem
        
        title = "History"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Test")
        
        do {
            history = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension HistoryTableVC {
// MARK: - Metods
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Test", in: managedContext)!
        let test = NSManagedObject(entity: entity, insertInto: managedContext)
        test.setValue(name, forKeyPath: "name")
        
        do {
            try managedContext.save()
            history.append(test)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func clear() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Test")
        
        if let history = try? managedContext.fetch(fetchRequest) {
            for test in history {
                managedContext.delete(test)
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
// MARK: - Private Metods
    private func configureView(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func newAttributeAlert() {
        let alert = UIAlertController(title: "New test", message: "Add a new test result", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in

            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text else {
                return
            }
            self?.save(name: nameToSave)
            self?.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc private func deleteAllAttributesAlert() {
        let alert = UIAlertController(title: "Clear history?", message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "Clear", style: .default) { [weak self] action in
            self?.clear()
            self?.history.removeAll()
            self?.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HistoryTableVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let test = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = test.value(forKeyPath: "name") as? String
        return cell
    }
}
