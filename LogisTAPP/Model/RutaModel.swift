//
//  RutaModel.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 3/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation

class RutaModel {
    var id : Int = 0
    var fecha : String = ""
    var listaSucursales = [SucursalModel]()
    var latitud : Double = 0
    var longitud : Double = 0
}
