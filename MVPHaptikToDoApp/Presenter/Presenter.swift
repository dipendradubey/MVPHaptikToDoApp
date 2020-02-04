//
//  Presenter.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 04/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import Foundation

class Presenter{
    let dbHandler: DBHandler!
    var delegate: DBHandlerDelegate? = nil
    init(_ dataProvider: DBHandler) {
        dbHandler = dataProvider
    }
    
    func fetchDataForPredicate(_ predicate: NSPredicate){
       let arrToDo = dbHandler.fetchToDo(predicate)
        delegate?.updateVCwithData(data: arrToDo)
    }
}
