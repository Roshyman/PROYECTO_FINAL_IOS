//
//  MisRotulacionesController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 29/5/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class CeldaMisRotulaciones: UITableViewCell {
    
    @IBOutlet weak var lblSucursal: UILabel!
    
    @IBOutlet weak var lblPOP: UILabel!
    @IBOutlet weak var lblComercio: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
}


class MisRotulacionesController: UITableViewController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LEE DE REALM LA LISTA DE ROTULACIONES GUARDADA
        variables.MiListaRotulaciones = [RotulacionModel]()
        let realm = try! Realm()
        let misRotus = realm.objects(RotulacionModel.self)
        for rotulacion in misRotus{
            let mirotu = RotulacionModel()
            mirotu.nombreComercio = (rotulacion.nombreComercio)
            mirotu.nombreSucursal = (rotulacion.nombreSucursal)
            mirotu.nombrePOP = (rotulacion.nombrePOP)
            mirotu.img1 = rotulacion.img1
            mirotu.img2 = rotulacion.img2
            variables.MiListaRotulaciones.append(mirotu)
            
        }
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variables.MiListaRotulaciones.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaRotulacion", for: indexPath) as! CeldaMisRotulaciones
        cell.lblComercio.text = variables.MiListaRotulaciones[indexPath.row].nombreComercio
        
        cell.lblPOP.text = variables.MiListaRotulaciones[indexPath.row].nombrePOP
        cell.lblSucursal.text = variables.MiListaRotulaciones[indexPath.row].nombreSucursal
        //cell.img1.image = UIImage(named: misEquipos.listado[indexPath.row].imagen)
        cell.img1.image = UIImage(data: variables.MiListaRotulaciones[indexPath.row].img1 as Data)
        cell.img2.image = UIImage(data: variables.MiListaRotulaciones[indexPath.row].img2 as Data)
        return cell
 
 
    }
    
}
