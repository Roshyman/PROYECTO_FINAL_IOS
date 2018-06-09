//
//  variables.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 3/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation

class variables {
    static var listaCatalogoPop = [PopModel]()
    static var listaCatalogoSucursales = [SucursalModel]()
    static var listaCatalogoComercios = [ComercioModel]()
    static var listaCatalogoEntidades = [EntidadModel]()
    static var listaNombresEntidades = [String]()
    static var listaNombresPOP = [String]()
    static var listaNombresSucursales = [String]()
    static var listaNombresComercios = [String]()
    static var MiListaRotulaciones = [RotulacionModel]()
    static var MiListaRutas = [RutaModel]()
    static var UsuarioActual = UsuarioModel()
    static var respuestaServicio : String = ""
    static var sucursalActual = SucursalModel()
}
