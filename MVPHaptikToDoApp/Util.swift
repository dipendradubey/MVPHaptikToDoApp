//
//  Util.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 03/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import Foundation

class UTil{
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter
    }()
    
    class func fetchStringFromDate()->String{
        return dateFormatter.string(from: Date())
    }
    
}
