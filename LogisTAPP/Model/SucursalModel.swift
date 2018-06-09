//
//  SucursalModel.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 3/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import RealmSwift
class SucursalModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var nombre: String = ""
    @objc dynamic var latitud: Double = 0.0
    @objc dynamic var longitud: Double = 0.0
    @objc dynamic var idComercio: Int = 0
    @objc dynamic var idEntidad: Int = 0
    
    
    
}
