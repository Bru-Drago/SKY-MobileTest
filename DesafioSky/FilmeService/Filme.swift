//
//  Filme.swift
//  DesafioSky
//
//  Created by Bruna Fernanda Drago on 24/06/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import Foundation

struct Filme : Decodable {
    
    var title:String
    var overview:String
    var duration:String
    var release_year:String
    var cover_url:String
    
}
