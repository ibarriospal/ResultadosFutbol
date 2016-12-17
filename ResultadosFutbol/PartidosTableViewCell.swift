//
//  PartidosTableViewCell.swift
//  ResultadosFutbol
//
//  Created by Nacho on 16/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class PartidosTableViewCell: UITableViewCell {
    @IBOutlet weak var escudoVisitante: UIImageView!

    @IBOutlet weak var escudoLocal: UIImageView!
    
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var local: UILabel!
    @IBOutlet weak var visitante: UILabel!
    @IBOutlet weak var hora: UILabel!
    @IBOutlet weak var minuto: UILabel!
}
