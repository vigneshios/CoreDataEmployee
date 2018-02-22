//
//  ViewController.swift
//  CoreData-SavingDataToDevice
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Vignesh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // Outlets:
    @IBOutlet weak var tableView: UITableView!
    
    // Variables:
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            let employee = try DataPersistence.context.fetch(fetchRequest)
            self.employees = employee
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch {
            print(error)
        }
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addEmployees() {
       let alert = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Designation"
        }
        
        let action = UIAlertAction(title: "Save", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let designation = alert.textFields!.last!.text!
        
            let employee = Employee(context: DataPersistence.context)
            employee.name = name
            employee.designation = designation
            DataPersistence.saveContext()
            self.employees.append(employee)
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = employees[indexPath.row].name
        cell.detailTextLabel?.text = employees[indexPath.row].designation
        return cell
    }
    
}
