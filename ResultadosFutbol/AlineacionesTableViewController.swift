//
//  AlineacionesTableViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 17/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class AlineacionesTableViewController: UITableViewController {

    var id = String()
    var url_con_id = String()
    let url_sin_id = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=9dfb8c3eb814f2a275da5830745820b8&itz=Europe/Madrid&format=json&req=match&id="
    
    var url: URL!
    var alineacionLocal = [[String:AnyObject]]()
    var alineacionVisitante = [[String:AnyObject]]()
    var datos = [String:AnyObject]()
    
    @IBOutlet weak var equipoLocal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                        
                        if let alineacionLocal2 = myJSON?["squad"]?["local"] {
                            DispatchQueue.main.async {
                                self.alineacionLocal = alineacionLocal2 as! [[String : AnyObject]]
                                self.tableView.reloadData()
                            }
                        }
                        if let alineacionVisitante2 = myJSON?["squad"]?["visitor"] {
                            DispatchQueue.main.async {
                                self.alineacionVisitante = alineacionVisitante2 as! [[String : AnyObject]]
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
        return min(alineacionVisitante.count, alineacionLocal.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let alineacionTable = tableView.dequeueReusableCell(withIdentifier: "alineacionCelda", for: indexPath) as! AlineacionTableViewCell
        
        let nombreJugadorLocal = alineacionLocal[indexPath.row]["nick"] as? String
        alineacionTable.jugadorLocal?.text = nombreJugadorLocal
        
        let nombreJugadorVisitante = alineacionVisitante[indexPath.row]["nick"] as? String
        alineacionTable.jugadorVisitante?.text = nombreJugadorVisitante
 
        return alineacionTable
    }
    
    @IBAction func volverDetalle(_segue: UIStoryboardSegue){
        
    }
}
