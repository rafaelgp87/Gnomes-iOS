//
//  Models.swift
//  Gnomes
//
//  Created by Rafael Gutiérrez on 06/07/20.
//  Copyright © 2020 Rafael Gutiérrez. All rights reserved.
//

import UIKit

struct StructGnomes: Decodable {
    let Brastlewark: [Gnome]
}

struct Gnome: Decodable {
    let id: Int
    let name: String
    let thumbnail: String
    let age: Int
    let weight: Float
    let height: Float
    let hair_color: String
}
