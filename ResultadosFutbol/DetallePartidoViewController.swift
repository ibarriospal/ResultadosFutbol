//
//  DetallePartidoViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 17/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class DetallePartidoViewController: UIViewController {

    @IBOutlet weak var escudoLocal: UIImageView!
    @IBOutlet weak var escudoVisitante: UIImageView!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var jornada: UILabel!
    @IBOutlet weak var visitanteAbbr: UILabel!
    @IBOutlet weak var localAbbr: UILabel!
    @IBOutlet weak var visitante: UILabel!
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var estadio: UILabel!
    
    @IBOutlet weak var alineacionLocal: UITableView!
    @IBOutlet weak var alineacionVisitante: UITableView!
    
    var detalle = [String:AnyObject]()
    var id = String()
    var url_con_id = String()
    let url_sin_id = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=9dfb8c3eb814f2a275da5830745820b8&itz=Europe/Madrid&format=json&req=match&id="
    
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        url_con_id = "\(url_sin_id)\(id)"
        url = URL(string: url_con_id)

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print ("error")
            }
            else {
                if let content =  data {
                    do {
                        //array
                        let myJSON =  try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
                        print(myJSON!)
                        
                            DispatchQueue.main.async {
                                self.detalle = (myJSON)!
                                
                                let nombreLocal = self.detalle["local"] as? String
                                self.local.text = nombreLocal
                                
                                let nombreVisitante = self.detalle["visitor"] as? String
                                self.visitante.text = nombreVisitante
                                
                                let nombreLocalAbbr = self.detalle["local_abbr"] as? String
                                self.localAbbr.text = nombreLocalAbbr
                                
                                let nombreVisitanteAbbr = self.detalle["visitor_abbr"] as? String
                                self.visitanteAbbr.text = nombreVisitanteAbbr
                                
                                let nombreJornada = self.detalle["round"] as? String
                                self.jornada.text = nombreJornada
                                
                                let nombreResultado = self.detalle["result"] as? String
                                self.resultado.text = nombreResultado
                                
                                let nombreEstadio = self.detalle["stadium"] as? String
                                self.estadio.text = nombreEstadio
                                
                                let imagenLocal = self.detalle["local_shield"] as? String
                                let url = URL(string: imagenLocal!)!
                                if let data = try? Data(contentsOf: url)  {
                                    if let img = UIImage(data: data) {
                                        DispatchQueue.main.async {
                                            self.escudoLocal?.image = img // Mostrar la imagen
                                        }
                                    } else {
                                        print("Error construyendo la imagen")
                                    }
                                } else {
                                    print("Error descargando")
                                }
                                
                                
                                let imagenVisitante = self.detalle["visitor_shield"] as? String
                                let url2 = URL(string: imagenVisitante!)!
                                if let data = try? Data(contentsOf: url2)  {
                                    if let img = UIImage(data: data) {
                                        DispatchQueue.main.async {
                                            self.escudoVisitante?.image = img // Mostrar la imagen
                                        }
                                    } else {
                                        print("Error construyendo la imagen")
                                    }
                                } else {
                                    print("Error descargando")
                                }

                            }
                    }
                    catch{
                        
                    }
                }
            }
        }
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Preparamos el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "alineacionesDesdeDetalle") {
            
            if let vc = segue.destination as? AlineacionesTableViewController {
                vc.id = self.id
            }
        }
        else {
            return
        }
    }
    
    @IBAction func volverDetalle(_segue: UIStoryboardSegue){
        
    }
    
}
