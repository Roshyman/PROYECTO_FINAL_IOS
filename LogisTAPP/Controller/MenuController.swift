//
//  MenuController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 29/5/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MenuController: UIViewController
{
    @IBOutlet weak var btnMisRotulaciones: UIButton!
    
    @IBOutlet weak var btnOlvidarUsuario: UIButton!
    @IBOutlet weak var btnSincronizar: UIButton!
    @IBOutlet weak var btnSalir: UIButton!
    
    @IBOutlet weak var btnMiRuta: UIButton!
    @IBOutlet weak var btnNuevaRotulacion: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSalir.layer.cornerRadius=60
        
        btnMiRuta.layer.cornerRadius=60
        
        btnSincronizar.layer.cornerRadius=60
        
        btnOlvidarUsuario.layer.cornerRadius=60
        
        btnMisRotulaciones.layer.cornerRadius=60
        
        btnNuevaRotulacion.layer.cornerRadius=60
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSalir(_ sender: UIButton) {
        
        let realm = try! Realm()
        let result = realm.objects(UsuarioModel.self)
        
        try! realm.write {
            realm.delete(result)
        }
        
        
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    
    @IBAction func btnOlvidarUsuario(_ sender: UIButton) {
        let realm = try! Realm()
        let result = realm.objects(UsuarioModel.self)
        
        try! realm.write {
            realm.delete(result)
        }
        
        
    }
    
}
