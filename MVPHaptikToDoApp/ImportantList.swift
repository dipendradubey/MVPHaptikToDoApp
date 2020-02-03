//
//  ImportantList.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 02/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import UIKit

class ImportantList: UITableViewController {
    
    lazy var predicate: NSPredicate = {
        let predicate1 = NSPredicate(format: "isdeleted == false")
        let predicate2 = NSPredicate(format: "isimp == true")
        let predicate3 = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2])
        return predicate3
        
    }()

    var arrToDo = [ToDo]()
    
    let cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        arrToDo = DBHandler.sharedManager.fetchToDo(predicate)
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrToDo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        let toDo = arrToDo[indexPath.row]
        cell.lblDate.text = toDo.datestr
        cell.lblTitle.text = toDo.title
        cell.lblDesc.text = toDo.desc
        return cell
    }
}
