//
//  PartidosTableViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 16/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class PartidosTableViewController: UITableViewController {
    
    var partidos = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let url = URL(string: "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=9dfb8c3eb814f2a275da5830745820b8&tz=Europe/Madrid&format=json&req=matchsday")
        
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
                        
                        if let results = myJSON?["matches"] {
                            DispatchQueue.main.async {
                                self.partidos = results as! [[String : AnyObject]]
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
        return self.partidos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let partidosTable = tableView.dequeueReusableCell(withIdentifier: "celdasPartidos", for: indexPath) as! PartidosTableViewCell
        
        let nombreLocal = partidos[indexPath.row]["local"] as? String
        partidosTable.local?.text = nombreLocal
        
        let nombreVisitante = partidos[indexPath.row]["visitor"] as? String
        partidosTable.visitante?.text = nombreVisitante
        
        let nombreResultado = partidos[indexPath.row]["result"] as? String
        partidosTable.resultado?.text = nombreResultado
        
        let nombreHora = partidos[indexPath.row]["hour"] as? String
        partidosTable.hora?.text = nombreHora
        
        let nombreMinuto = partidos[indexPath.row]["minute"] as? String
        partidosTable.minuto?.text = nombreMinuto
        
        
        
        let imagenLocal = partidos[indexPath.row]["local_shield"] as? String
        let url = URL(string: imagenLocal!)!
        if let data = try? Data(contentsOf: url)  {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    partidosTable.escudoLocal?.image = img // Mostrar la imagen
                }
            } else {
                print("Error construyendo la imagen")
            }
        } else {
            print("Error descargando")
        }
        
        
        let imagenVisitante = partidos[indexPath.row]["visitor_shield"] as? String
        let url2 = URL(string: imagenVisitante!)!
        if let data = try? Data(contentsOf: url2)  {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    partidosTable.escudoVisitante?.image = img // Mostrar la imagen
                }
            } else {
                print("Error construyendo la imagen")
            }
        } else {
            print("Error descargando")
        }
        
        
        // Ocultar indicador de actividad de red
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        return partidosTable
        
    }
    
    
}

