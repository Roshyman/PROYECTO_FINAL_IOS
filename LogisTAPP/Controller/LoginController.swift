//
//  LoginController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 29/5/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var lblRecordarme: UILabel!
    @IBOutlet weak var swiRecordar: UISwitch!
    
    @IBOutlet weak var txtUsuario: UITextField!
    
    @IBOutlet weak var txtContra: UITextField!
    
    
    @IBOutlet weak var btnIngresar: UIButton!
    
    @IBOutlet weak var btnSalir: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSalir.layer.cornerRadius=55
        btnIngresar.layer.cornerRadius=55
        
        swiRecordar.addTarget(self, action: #selector(stateChanged), for: UIControlEvents.valueChanged)
        
       
        
        //VALIDA EN REALM SI YA ESTA LOGUEADO EL USUARIO
        let realm = try! Realm()
        let usuarios = realm.objects(UsuarioModel.self)
        if(usuarios.count != 0){
            variables.UsuarioActual.id = usuarios[0].id
            variables.UsuarioActual.nombreCompleto = usuarios[0].nombreCompleto
            variables.UsuarioActual.nombreUsuario = usuarios[0].nombreUsuario
            
            //ENVIA A VIEW MAIN
            UserDefaults.standard.set(true, forKey: "status")
            Switcher.updateRootVC()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func stateChanged(switchState: UISwitch) {
        if swiRecordar.isOn {
            lblRecordarme.text = "Recordar mis datos"
        } else {
            lblRecordarme.text = "No recordar mis datos"
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        //LLAMA A WEB API PARA VALIDAR USUARIO
        
        APIManager.sharedInstance.getUsuario(nombreUsuario: txtUsuario.text!,contrasena:txtContra.text!, onSuccess: { json in
            DispatchQueue.main.async {
                //self.txtUsuario.text = String(describing: json)
                 variables.respuestaServicio = String(describing: json)
                //SI EL WEB API REGRESA RESPUESTA
                if(variables.respuestaServicio != ""){
                    //DESERIALIZA LA RESPUESTA Y LA GUARDA EN OBJETO USUARIO
                    let datosJson: NSData =  variables.respuestaServicio.data(using: String.Encoding.utf8)! as NSData
                    
                    let datos = try? JSONSerialization.jsonObject(with: datosJson as Data, options: .mutableContainers) as? [String:Any]
                    
                    //GUARDA LO DATOS EN OBJETO GLOBAL
                    variables.UsuarioActual = UsuarioModel()
                    variables.UsuarioActual.id = (datos!!["id"] as? Int)!
                    if(variables.UsuarioActual.id != 0){
                        variables.UsuarioActual.nombreCompleto = (datos!!["nombreCompleto"] as? String)!
                        variables.UsuarioActual.nombreUsuario = (datos!!["nombreUsuario"] as? String)!
                        
                        //SI DEBE RECORDAR CONTRASEÑA LA ALMACENA EN REALM
                        if(self.swiRecordar.isOn){
                            let realm = try! Realm()
                            try! realm.write {
                                realm.add(variables.UsuarioActual)
                            }
                        }
                        
                        //ENVIA A VIEW MAIN
                        UserDefaults.standard.set(true, forKey: "status")
                        Switcher.updateRootVC()
                    }
                    else{
                        let alertController = UIAlertController(title: "LogisTAPP", message:
                            "Usuario y/o Contraseña Incorrecta!", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "LogisTAPP", message:
                        "Usuario y/o Contraseña Incorrecta!", preferredStyle: UIAlertControllerStyle.alert)
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
    
}

