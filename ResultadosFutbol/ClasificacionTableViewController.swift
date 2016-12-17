//
//  ClasificacionTableViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 17/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class ClasificacionTableViewController: UITableViewController {

    var id = String()
    var url_con_id = String()
    let url_sin_id = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=9dfb8c3eb814f2a275da5830745820b8&tz=Europe/Madrid&format=json&req=tables&league="
    
    var url: URL!
    var clasificacion = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
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
                        
                        if let calsificacion2 = myJSON?["table"] {
                            DispatchQueue.main.async {
                                self.clasificacion = calsificacion2 as! [[String : AnyObject]]
                                self.tableView.reloadData()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clasificacion.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let clasificacionTable = tableView.dequeueReusableCell(withIdentifier: "clasificacionCelda", for: indexPath) as! ClasificacionTableViewCell
        
        let nombreEquipo = clasificacion[indexPath.row]["team"] as? String
        clasificacionTable.equipo?.text = nombreEquipo
        
        let nombrePuntos = clasificacion[indexPath.row]["points"] as? String
        clasificacionTable.puntos?.text = nombrePuntos
        
    
        let imagenEquipo = clasificacion[indexPath.row]["shield"] as? String
        let url = URL(string: imagenEquipo!)!
        if let data = try? Data(contentsOf: url)  {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    clasificacionTable.escudo?.image = img // Mostrar la imagen
                }
            } else {
                print("Error construyendo la imagen")
            }
        } else {
            print("Error descargando")
        }
        
        let puesto = indexPath.row + 1
        clasificacionTable.puesto?.text = String(puesto)
        
        // Ocultar indicador de actividad de red
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        return clasificacionTable
        
    }

}
