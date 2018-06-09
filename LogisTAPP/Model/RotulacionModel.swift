//
//  RotulacionModel.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 3/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import RealmSwift
class RotulacionModel: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var nombreEntidad: String = ""
    @objc dynamic var nombreComercio: String = ""
    @objc dynamic var nombreSucursal: String = ""
    @objc dynamic var nombrePOP: String = ""
    @objc dynamic var img1 =  NSData()
    @objc dynamic var img2 = NSData()
    @objc dynamic var img3 = NSData()
}
