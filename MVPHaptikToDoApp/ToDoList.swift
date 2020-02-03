//
//  ToDoList.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 02/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import UIKit

class ToDoList: UITableViewController {
    
    lazy var strokeEffect: [NSAttributedString.Key : Any] = {
       return [
        NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
        NSAttributedString.Key.strikethroughColor: UIColor.black,
        ]
    }()
    var arrToDo = [ToDo]()
    
    let cellIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        arrToDo = DBHandler.sharedManager.fetchToDo(NSPredicate(format: "isdeleted == false"))
        tableView.reloadData()
    }
    
    @IBAction func btnAddToDoClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ToDoVC")
        let nav = UINavigationController(rootViewController: vc!)
        present(nav, animated: true, completion: nil)
    
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrToDo.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        let toDo = arrToDo[indexPath.row]
        cell.lblDate.text = toDo.datestr
        cell.lblTitle.text = toDo.title
        if toDo.iscompleted {
            cell.lblDesc.attributedText = NSAttributedString(string: toDo.desc ?? "", attributes: strokeEffect)
        }
        else{
            cell.lblDesc.text = toDo.desc
        }
        

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        ->   UISwipeActionsConfiguration? {
            let toDo = arrToDo[indexPath.row]
            //Adding destuctive will cause to delete the cell automatically
            let action = UIContextualAction(style: .destructive, title: "Delete",
                                            handler: { (action, view, completionHandler) in
                                                DBHandler.sharedManager.persistentContainer.viewContext.delete(toDo)
                                                DBHandler.sharedManager.saveContext()
                                                completionHandler(true)
            })
            
            //IT's good we can add image & background color too
            //action.image = UIImage(named: "heart")
            //action.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [action])
            return configuration
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let toDo = arrToDo[indexPath.row]
        
        let doneAction = UIContextualAction(style: .normal, title: "Done",
                                        handler: { (action, view, completionHandler) in
                                            //Add action here
                                            toDo.iscompleted = true
                                            DBHandler.sharedManager.saveContext()
                                            tableView.reloadRows(at: [indexPath], with: .fade)
                                            completionHandler(true)
        })
        doneAction.backgroundColor = .red
        
        let completeAction = UIContextualAction(style: .normal, title: "Mark Important",
                                            handler: { (action, view, completionHandler) in
                                                //Add action here
                                                toDo.isimp = true
                                                DBHandler.sharedManager.saveContext()
                                                completionHandler(true)
        })
        completeAction.backgroundColor = .orange
        
        let configuration = UISwipeActionsConfiguration(actions: [doneAction, completeAction])
        return configuration
    }

}
