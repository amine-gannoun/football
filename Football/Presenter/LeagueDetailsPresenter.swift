//
//  LeagueDetailsPresenter.swift
//  Football
//
//  Created by Amine  on 01/10/2022.
//

import UIKit

protocol LeagueDetailsPresenterDelegate : NSObject {
    func didGetTeams(teams : [Team])
}

class LeagueDetailsPresenter {
    
    weak var delegate : LeagueDetailsPresenterDelegate?
    
    public func setDelegate(delegate : LeagueDetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getAllTeams(strLeague: String){
        
        LeagueManager.shared.getLeagueTeams(strLeague: strLeague, CompletionHandler: { teams in
            self.delegate?.didGetTeams(teams: teams)
        })
        
    }
    
}
