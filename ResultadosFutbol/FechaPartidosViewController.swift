//
//  FechaPartidosViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 19/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class FechaPartidosViewController: UIViewController {

    @IBOutlet weak var fechaPartido: UIDatePicker!
    var formatter:DateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pasarFecha") {
            if let vc = segue.destination as? PartidosTableViewController {
                formatter.dateFormat = "yyyy'-'MM'-'dd"
                vc.fecha = formatter.string(from: fechaPartido.date)
            }
        }
        else {
            return
        }
    }

    @IBAction func volverFecha(_segue: UIStoryboardSegue){
        
    }
}
