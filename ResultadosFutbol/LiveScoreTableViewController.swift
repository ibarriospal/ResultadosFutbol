//
//  LiveScoreTableViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 17/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class LiveScoreTableViewController: UITableViewController {

    var liveScore = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let url = URL(string: "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=9dfb8c3eb814f2a275da5830745820b8&tz=Europe/Madrid&format=json&req=livescore")
        
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
                        
                        if let liveScore2 = myJSON?["matches"] {
                            DispatchQueue.main.async {
                                self.liveScore = liveScore2 as! [[String : AnyObject]]
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
        return self.liveScore.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableLiveScore = tableView.dequeueReusableCell(withIdentifier: "celdasLiveScore", for: indexPath) as! LiveScoreTableViewCell
        
        let nombreLocal = liveScore[indexPath.row]["local"] as? String
        tableLiveScore.local?.text = nombreLocal
        
        let nombreResultado = liveScore[indexPath.row]["result"] as? String
        tableLiveScore.resultado?.text = nombreResultado
        
        let nombreVisitante = liveScore[indexPath.row]["visitor"] as? String
        tableLiveScore.visitante?.text = nombreVisitante
        
        
        let imagenLocal = liveScore[indexPath.row]["local_shield"] as? String
        let url = URL(string: imagenLocal!)!
        if let data = try? Data(contentsOf: url)  {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    tableLiveScore.escudoLocal?.image = img // Mostrar la imagen
                }
            } else {
                print("Error construyendo la imagen")
            }
        } else {
            print("Error descargando")
        }
        
        
        let imagenVisitante = liveScore[indexPath.row]["visitor_shield"] as? String
        let url2 = URL(string: imagenVisitante!)!
        if let data = try? Data(contentsOf: url2)  {
            if let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    tableLiveScore.escudoVisitante?.image = img // Mostrar la imagen
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
        return tableLiveScore
        
    }
    
    //Preparamos el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detallePartidoDesdeLiveScore") {
            
            if let vc = segue.destination as? DetallePartidoViewController {
                let indexPath = tableView.indexPathForSelectedRow
                vc.id = (liveScore[(indexPath?.row)!]["id"] as? String)!
            }
        }
        else {
            return
        }
    }
    
    @IBAction func volverLiveScore(_segue: UIStoryboardSegue){
        
    }
}
