//
//  FestivalsModel.swift
//  Festivals
//
//  Created by gurjeet singh on 22/7/21.
//

import Foundation


struct Festival: Codable {
    let name: String?
    let bands: [Band]?
}

struct Band: Codable {
    let name: String?
    let recordLabel: String?
}

struct RestructFestivals: Codable {
    let bandName: String?
    let name: String?
    let recordLabel: String?
}
