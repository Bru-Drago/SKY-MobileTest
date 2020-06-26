//
//  FilmeCollectionViewCell.swift
//  DesafioSky
//
//  Created by Bruna Fernanda Drago on 24/06/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import UIKit

class FilmeCollectionViewCell: UICollectionViewCell {
   
    //Outlets
    @IBOutlet weak var capaImageView: UIImageView!
    @IBOutlet weak var tituloFilmeLabel: UILabel!
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
        
        setUpCell()
        
    }
    
    func setUpCell(){
        
        capaImageView.layer.cornerRadius = 10
        capaImageView.clipsToBounds = true
    }
    
}
