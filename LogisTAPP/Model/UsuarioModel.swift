//
//  UsuarioModel.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 3/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import RealmSwift
class UsuarioModel: Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var nombreUsuario : String = ""
    @objc dynamic var contrasena : String = ""
    @objc dynamic var nombreCompleto : String = ""
}
