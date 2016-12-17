//
//  LiveScoreTableViewCell.swift
//  ResultadosFutbol
//
//  Created by Nacho on 17/12/16.
//  Copyright © 2016 UPM. All rights reserved.
//

import UIKit

class LiveScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var escudoVisitante: UIImageView!

    @IBOutlet weak var escudoLocal: UIImageView!
    @IBOutlet weak var local: UILabel!
    
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var visitante: UILabel!
    
}
