//
//  NuevaRotulacionController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 29/5/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import RealmSwift

private extension Selector {
    static let openPickerButtonTapped = #selector(NuevaRotulacionController.openPickerButtonTapped)
}

class NuevaRotulacionController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    var cantidadImagenes : Int = 0
    var idEntidadActual : Int = 0
    var idComercioActual : Int = 0
    var idSucursalActual : Int = 0
    var idPopActual : Int = 0
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var btnGuardar: UIButton!
    
    @IBOutlet weak var pckEntidad: UIPickerView!
    
    @IBOutlet weak var pckComercio: UIPickerView!
    
    @IBOutlet weak var pckSucursal: UIPickerView!
    
    @IBOutlet weak var pckPop: UIPickerView!
    
    @IBOutlet weak var lblComercio: UILabel!
    
    @IBOutlet weak var lblSucursal: UILabel!
    
    
    
   
    
    private lazy var openPickerButton: UIBarButtonItem = {
        let b = UIBarButtonItem(
            title: "Tomar Foto",
            style: .done,
            target: self,
            action: .openPickerButtonTapped
        )
        return b
    }()
    
   
    fileprivate lazy var imagePicker: UIImagePickerController = {
        let i = UIImagePickerController()
        i.delegate = self
        return i
    }()
    
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        let nuevaRot = RotulacionModel()
        
        nuevaRot.nombreComercio = variables.listaCatalogoComercios[pckComercio.selectedRow(inComponent: idComercioActual)].nombre
       
        nuevaRot.nombreEntidad = variables.listaCatalogoEntidades[pckEntidad.selectedRow(inComponent: idEntidadActual)].nombre
       
        nuevaRot.nombreSucursal = variables.listaCatalogoSucursales[pckSucursal.selectedRow(inComponent: idSucursalActual)].nombre
        
        nuevaRot.nombrePOP = variables.listaCatalogoPop[pckPop.selectedRow(inComponent: idPopActual)].nombre
        nuevaRot.img1 = NSData(data: UIImageJPEGRepresentation(img1.image!,0.9)!)
        nuevaRot.img2 = NSData(data: UIImageJPEGRepresentation(img2.image!,0.9)!)
        nuevaRot.img3 = NSData(data: UIImageJPEGRepresentation(img3.image!,0.9)!)
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(nuevaRot)
        }
        
        let alertController = UIAlertController(title: "LogisTAPP", message:
            "Rotulación Almacenada!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        variables.listaCatalogoPop = [PopModel]()
       // variables.listaCatalogoEntidades = [EntidadModel]()
        variables.listaCatalogoSucursales = [SucursalModel]()
        variables.listaCatalogoComercios = [ComercioModel]()
       // variables.listaNombresEntidades = [String]()
        btnGuardar.layer.cornerRadius=10
        navigationItem.rightBarButtonItem = openPickerButton
        //pckEntidad.delegate = self
        //pckEntidad.dataSource = self
        //pckSucursal.delegate = self
        //pckSucursal.dataSource = self
        //pckPop.delegate = self
        //pckPop.dataSource = self
        //pckComercio.delegate = self
        //ckComercio.dataSource = self
        pckComercio.isHidden = true
        pckSucursal.isHidden = true
        lblComercio.isHidden = true
        lblSucursal.isHidden = true
        //CARGA LISTA DE ENTIDADES
        ObtenerEntidades()
        //CARGA LISTA DE MATERIALES POP
        ObtenerPop()
        
    }
    
    
    //DELEGADOS PARA PICKER
    
    func numberOfComponents(in pickerView : UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return variables.listaCatalogoEntidades.count
        }
        if(pickerView.tag == 2){
            return variables.listaCatalogoComercios.count
        }
        if(pickerView.tag == 3){
            return variables.listaCatalogoSucursales.count
        }
        if(pickerView.tag == 4){
            return variables.listaCatalogoPop.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 1){
             return variables.listaNombresEntidades[row]
        }else
        if(pickerView.tag == 2){
             return variables.listaNombresComercios[row]
        }else
        if(pickerView.tag == 3){
            return variables.listaNombresSucursales[row]
        }else
        if(pickerView.tag == 4){
            return variables.listaNombresPOP[row]
        }else{
            return "uio"
        }
       
    }
    
   
    
    /*
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //if(pickerView.tag == 1){
            return variables.listaNombresEntidades[row]
        //}else if(pickerView.tag == 2){
          //  return variables.listaNombresEntidades[row]
        //}
        /*else if(pickerView.tag == 3){
            return variables.listaNombresEntidades[row]
        }
        else if(pickerView.tag == 4){
            return variables.listaNombresEntidades[row]
        }
        else{
            return ""
        }*/
        
        
    }*/
    
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int)
    {
        if(pickerView.tag == 1){
            ObtenerComercios(pIdEntidad: variables.listaCatalogoEntidades[row].id)
            pckComercio.isHidden = false
            lblComercio.isHidden = false
            idEntidadActual = row
        }
        if(pickerView.tag == 2){
            ObtenerSucursales(pIdComercio: variables.listaCatalogoComercios[row].id)
            pckSucursal.isHidden = false
            lblSucursal.isHidden = false
            idComercioActual = row
        }
        if(pickerView.tag == 3){
            idSucursalActual = row
        }
        if(pickerView.tag == 4){
           idPopActual = row
        }
    }
    //FIN DELEGADOS PARA PICKER
    
    
    func ObtenerEntidades(){
        //LLAMA A WEB API PARA VALIDAR OBTENER LAS ENTIDADES
        
        APIManager.sharedInstance.getEntidades(onSuccess: { json in
            DispatchQueue.main.async {
                
                variables.respuestaServicio = String(describing: json)
                //SI EL WEB API REGRESA RESPUESTA
                if(variables.respuestaServicio != ""){
                    //DESERIALIZA LA RESPUESTA Y LA GUARDA EN LISTA DE ENTIDADES
                    let datosJson: NSData =  variables.respuestaServicio.data(using: String.Encoding.utf8)! as NSData
                    
                    let datos = try? JSONSerialization.jsonObject(with: datosJson as Data, options: JSONSerialization.ReadingOptions()) as? [[String:Any]]
                    
                    //GUARDA LO DATOS EN OBJETO GLOBAL
                   
                    for item in datos!!{
                        var entidad = EntidadModel()
                        entidad.id = (item["id"] as! Int)
                        if (entidad.id == 0){
                            let alertController = UIAlertController(title: "LogisTAPP", message:
                                "No se pudo obtener la lista de entidades", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else{
                            entidad.nombre = (item["nombre"] as! String)
                            variables.listaCatalogoEntidades.append(entidad)
                            variables.listaNombresEntidades.append((item["nombre"] as! String))
                        }
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "LogisTAPP", message:
                            "No se pudo obtener la lista de entidades", preferredStyle: UIAlertControllerStyle.alert)
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
    
    
    func ObtenerComercios(pIdEntidad : Int){
        //LLAMA A WEB API PARA OBTENER LOS COMERCIOS
        
        APIManager.sharedInstance.getComercios( entidadId: pIdEntidad, onSuccess: { json in
            DispatchQueue.main.async {
                
                variables.respuestaServicio = String(describing: json)
                //SI EL WEB API REGRESA RESPUESTA
                if(variables.respuestaServicio != ""){
                    //DESERIALIZA LA RESPUESTA Y LA GUARDA EN LISTA DE COMERCIOS
                    let datosJson: NSData =  variables.respuestaServicio.data(using: String.Encoding.utf8)! as NSData
                    
                    let datos = try? JSONSerialization.jsonObject(with: datosJson as Data, options: JSONSerialization.ReadingOptions()) as? [[String:Any]]
                    
                    //GUARDA LO DATOS EN OBJETO GLOBAL
                    
                    for item in datos!!{
                        var comercio = ComercioModel()
                        comercio.id = (item["id"] as! Int)
                        if (comercio.id == 0){
                            let alertController = UIAlertController(title: "LogisTAPP", message:
                                "No se pudo obtener la lista de comercios", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else{
                            comercio.nombre = (item["nombre"] as! String)
                            variables.listaCatalogoComercios.append(comercio)
                            variables.listaNombresComercios.append((item["nombre"] as! String))
                        }
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "LogisTAPP", message:
                        "No se pudo obtener la lista de comercios", preferredStyle: UIAlertControllerStyle.alert)
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
    
    
    func ObtenerSucursales(pIdComercio : Int){
        //LLAMA A WEB API PARA OBTENER LAS SUCURSALES
        
        APIManager.sharedInstance.getSucursales( comercioId: pIdComercio, onSuccess: { json in
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
    
    
    
    func ObtenerPop(){
        //LLAMA A WEB API PARA OBTENER LA LISTA DE MATERIAL POP
        
        APIManager.sharedInstance.getPop(onSuccess: { json in
            DispatchQueue.main.async {
                
                variables.respuestaServicio = String(describing: json)
                //SI EL WEB API REGRESA RESPUESTA
                if(variables.respuestaServicio != ""){
                    //DESERIALIZA LA RESPUESTA Y LA GUARDA EN LISTA DE COMERCIOS
                    let datosJson: NSData =  variables.respuestaServicio.data(using: String.Encoding.utf8)! as NSData
                    
                    let datos = try? JSONSerialization.jsonObject(with: datosJson as Data, options: JSONSerialization.ReadingOptions()) as? [[String:Any]]
                    
                    //GUARDA LO DATOS EN OBJETO GLOBAL
                    
                    for item in datos!!{
                        let POP = PopModel()
                        POP.id = (item["id"] as! Int)
                        if (POP.id == 0){
                            let alertController = UIAlertController(title: "LogisTAPP", message:
                                "No se pudo obtener la lista de materiales POP", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Salir", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        else{
                            POP.nombre = (item["nombre"] as! String)
                            variables.listaCatalogoPop.append(POP)
                            variables.listaNombresPOP.append((item["nombre"] as! String))
                        }
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "LogisTAPP", message:
                        "No se pudo obtener la lista de materiales pop", preferredStyle: UIAlertControllerStyle.alert)
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



extension NuevaRotulacionController {
    @objc
    fileprivate func openPickerButtonTapped() {
        let sheet = UIAlertController(
            title: "Tomar Foto",
            message: "Seleccione...",
            preferredStyle: .actionSheet
        )
        sheet.addAction(UIAlertAction(title: "Galería", style: .default, handler: { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet.addAction(UIAlertAction(title: "Cámara", style: .default, handler: { action in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }))
        }
        sheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(sheet, animated: true, completion: nil)
    }
}


//Image Picker Delegate
extension NuevaRotulacionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        if (cantidadImagenes==0){
            img1.image = image
            cantidadImagenes = 1
        }else if (cantidadImagenes==1){
            img2.image = image
            cantidadImagenes = 2
        }else if (cantidadImagenes==2){
            img3.image = image
            cantidadImagenes = 0
        }
    }
}

