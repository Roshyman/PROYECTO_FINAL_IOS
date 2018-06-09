//
//  MapaController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 8/6/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class MapaController: UIViewController{
    
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: variables.sucursalActual.latitud,
                                              longitude: variables.sucursalActual.longitud)
        
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapa.setRegion(region, animated: true)
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = variables.sucursalActual.nombre
      
        mapa.addAnnotation(annotation)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

