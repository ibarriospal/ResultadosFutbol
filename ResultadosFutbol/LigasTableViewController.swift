//
//  LigasTableViewController.swift
//  ResultadosFutbol
//
//  Created by Nacho on 16/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class LigasTableViewController: UITableViewController {

    var ligas = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let url = URL(string: "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=9dfb8c3eb814f2a275da5830745820b8&format=json&req=leagues&top=1&tz=Europe/Madrid")
        
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
                        
                        if let ligasBurnas = myJSON?["league"] {
                        DispatchQueue.main.async {
                            self.ligas = ligasBurnas as! [[String : AnyObject]]
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
        return self.ligas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdas = tableView.dequeueReusableCell(withIdentifier: "celdasLiga", for: indexPath) as! CeldaLigaTableViewCell
        
        let nombreLiga = ligas[indexPath.row]["name"] as? String
        celdas.labelLigas?.text = nombreLiga
        

        let imagenLiga = ligas[indexPath.row]["logo"] as? String
        let url = URL(string: imagenLiga!)!
        if let data = try? Data(contentsOf: url)  {
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                    celdas.imagenLigas?.image = img // Mostrar la imagen
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
        return celdas

        }

    //Preparamos el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueClasificacion") {
            
            if let vc = segue.destination as? ClasificacionTableViewController {
                let indexPath = tableView.indexPathForSelectedRow
                vc.id = (ligas[(indexPath?.row)!]["id"] as? String)!
            }
        }
        else {
            return
        }
    }
    
    @IBAction func volverLiga(_segue: UIStoryboardSegue){
        
    }
}


