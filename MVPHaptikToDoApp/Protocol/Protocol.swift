//
//  Protocol.swift
//  MVPHaptikToDoApp
//
//  Created by Dipendra Dubey on 04/02/20.
//  Copyright © 2020 Dipendra. All rights reserved.
//

import Foundation

protocol DBHandlerDelegate{
    func updateVCwithData(data: [ToDo])
}
