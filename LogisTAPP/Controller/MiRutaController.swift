//
//  MiRutaController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 29/5/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class CeldaMiRuta: UITableViewCell {
    
    @IBOutlet weak var lblLatitud: UILabel!
    @IBOutlet weak var lblLongitud: UILabel!
    
    @IBOutlet weak var lblFecha: UILabel!
    
    
    @IBAction func btnVerMapa(_ sender: UIButton) {
        variables.sucursalActual = SucursalModel()
        variables.sucursalActual.latitud = Double(lblLatitud.text!)!
        variables.sucursalActual.longitud = Double(lblLongitud.text!)!
        variables.sucursalActual.nombre = lblFecha.text!
        
    }
    
    
    
}
class MiRutaController: UITableViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ObtenerMisRutas()
    }
    
    func ObtenerMisRutas(){
        
        APIManager.sharedInstance.getSucursales( comercioId: 1, onSuccess: { json in
            DispatchQueue.main.async {
                
                variables.respuestaServicio = String(describing: json)
                //SI EL WEB API REGRESA RESPUESTA
                if(variables.respuestaServicio != ""){
                    //DESERIALIZA LA RESPUESTA Y LA GUARDA EN LISTA DE COMERCIOS
                    let datosJson: NSData =  variables.respuestaServicio.data(using: String.Encoding.utf8)! as NSData
                    
                    let datos = try? JSONSerialization.jsonObject(with: datosJson as Data, options: JSONSerialization.ReadingOptions()) as? [[String:Any]]
                    
                    //GUARDA LO DATOS EN OBJETO GLOBAL
                    
                    for item in datos!!{
                        var sucursal = SucursalModel()
                        sucursal.id = (item["id"] as! Int)
                        if (sucursal.id == 0){
                            let alertController = UIAlertController(title: "LogisTAPP", message:
                                "No se pudo obtener la lista de sucursales", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else{
                            sucursal.nombre = (item["nombre"] as! String)
                            sucursal.idComercio = (item["idComercio"] as! Int)
                            sucursal.idEntidad = (item["idEntidad"] as! Int)
                            sucursal.latitud = (item["latitud"] as! Double)
                            sucursal.longitud = (item["longitud"] as! Double)
                            variables.listaCatalogoSucursales.append(sucursal)
                            variables.listaNombresSucursales.append((item["nombre"] as! String))
                        }
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "LogisTAPP", message:
                        "No se pudo obtener la lista de sucursales", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Error", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variables.listaCatalogoSucursales.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaRuta", for: indexPath) as! CeldaMiRuta
       
        cell.lblFecha.text = String(variables.listaCatalogoSucursales[indexPath.row].nombre)
        
        cell.lblLatitud.text = String(variables.listaCatalogoSucursales[indexPath.row].latitud)
        cell.lblLongitud.text = String(variables.listaCatalogoSucursales[indexPath.row].longitud)
        //cell.img1.image = UIImage(named: misEquipos.listado[indexPath.row].imagen)
        
        return cell
        
        
    }
    
    
}
