//
//  APIManager.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 4/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import SwiftyJSON
class APIManager: NSObject{
    
    let baseURL = "https://www.pts.cr/WS_MASTERUP/api"
    static let sharedInstance = APIManager()
    static let sufUsuarioEndPoint = "/prueba/getusuario"
    static let sufEntidadesEndPoint = "/prueba/GetEntidades"
    static let sufSucusarlesEndPoint = "/prueba/GetSucursales/"
    static let sufComerciosEndPoint = "/prueba/GetComercios/"
    static let sufPOPEndPoint = "/prueba/GetPOP/"
    static let gsufRutaEndPoint = "/prueba/GetRuta/"
    
    func getUsuario(nombreUsuario: String, contrasena: String, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + APIManager.sufUsuarioEndPoint + "?nombreusuario=" + String(nombreUsuario) + "&contrasena=" + String(contrasena)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch{
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
    
    
    func getEntidades(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + APIManager.sufEntidadesEndPoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch{
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
    
    
    func getComercios(entidadId: Int,onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + APIManager.sufComerciosEndPoint + "?idEntidad=" + String(entidadId)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch{
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
    
    
    func getSucursales(comercioId: Int,onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + APIManager.sufSucusarlesEndPoint + "?idComercio=" + String(comercioId)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch{
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
    
    
    func getPop(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + APIManager.sufPOPEndPoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch{
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
    
    
    
    func getRutas(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + APIManager.gsufRutaEndPoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do{
                    let result = try JSON(data: data!)
                    onSuccess(result)
                }
                catch{
                    onFailure(error)
                }
            }
        })
        task.resume()
    }
    
    
    
    
}
