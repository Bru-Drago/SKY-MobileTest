//
//  FilmeInfoViewController.swift
//  DesafioSky
//
//  Created by Bruna Fernanda Drago on 24/06/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import UIKit

class FilmeInfoViewController: UIViewController {
    
    @IBOutlet weak var duracaoLabel: UILabel!
    @IBOutlet weak var anoLabel: UILabel!
    @IBOutlet weak var tempoDuracaoLabel: UILabel!
    @IBOutlet weak var anoLancamentoLabel: UILabel!
    @IBOutlet weak var resumoTextView: UITextView!
    @IBOutlet weak var capaImageView: UIImageView!
    @IBOutlet weak var tituloFilmeLabel: UILabel!
    
    
    var filme : Filme?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tituloFilmeLabel.text = filme?.title
        resumoTextView.text = filme?.overview
       // anoLancamentoLabel.text = filme?.release_year
        anoLancamentoLabel.text = filme?.releaseYear
        tempoDuracaoLabel.text = filme?.duration
        
        //Fazendo o download e setUp da imagem
        capaImageView.layer.cornerRadius = 10
        capaImageView.clipsToBounds = true
        let img = (filme?.coverUrl)!
        print(img)
        capaImageView.downloaded(from: img)
        
        
    }
    


}
