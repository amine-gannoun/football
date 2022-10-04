//
//  League.swift
//  Football
//
//  Created by Amine  on 01/10/2022.
//

import UIKit

struct AllLeagues : Codable {
    var leagues : [League]
}

struct League : Codable {
    var idLeague : String?
    var strLeague : String
    var strSport : String?
    var strLeagueAlternate : String?
}
