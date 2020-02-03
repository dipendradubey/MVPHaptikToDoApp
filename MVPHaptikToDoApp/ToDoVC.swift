//
//  ToDoVC.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 02/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import UIKit

class ToDoVC: UIViewController {
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var txtField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelClicked))
        self.title = "ToDo"

        // Do any additional setup after loading the view.
    }
    
    @objc func cancelClicked(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveClicked(_ sender: Any) {
        let dbHander = DBHandler.sharedManager
        let managedObjectContext = dbHander.persistentContainer.viewContext
        
        //Create to do
        let toDo = ToDo(context: managedObjectContext)
        toDo.title = self.txtField.text!
        toDo.desc = self.txtView.text!
        toDo.date = Date() as NSDate
        toDo.datestr = UTil.fetchStringFromDate()

        //Below are not necessary as i have set default value for these property under .xcdatamodel ID
        //Select the field name and set default value for these
//        toDo.isimp = false
//        toDo.isdeleted = false
        
        //managedObjectContext.insert(toDo)
        dbHander.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
