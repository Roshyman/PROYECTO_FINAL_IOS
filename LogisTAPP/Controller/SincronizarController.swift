//
//  SincronizarController.swift
//  LogisTAPP
//
//  Created by Ronald Murillo Solano on 29/5/18.
//  Copyright © 2018 Ronald Murillo Solano. All rights reserved.
//

import Foundation
import UIKit

class SincronizarController: UIViewController
{
    
    @IBOutlet weak var progreso: UIProgressView!
    @IBOutlet weak var btnincronizar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnincronizar.layer.cornerRadius=55
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
