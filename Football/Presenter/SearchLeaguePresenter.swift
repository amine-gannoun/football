//
//  SearchLeaguePresenter.swift
//  Football
//
//  Created by Amine  on 30/09/2022.
//

import UIKit

protocol SearchLeaguePresenterDelegate : AnyObject {
    func didFilterLeagues(leagues: [League])
}



class SearchLeaguePresenter {
    
    weak var delegate : SearchLeaguePresenterDelegate?
    var soccerLeagues : [League] = []
    
    public func setViewDelegate(delegate : SearchLeaguePresenterDelegate){
        self.delegate = delegate
    }
    
    public func getAllSoccerLeagues() {
        
        LeagueManager.shared.getSoccerLeagues { leagues in
            self.soccerLeagues = leagues
        }
        
    }
    
    public func filterLeagues(name: String) {
        self.delegate?.didFilterLeagues(leagues: soccerLeagues.filter { league in
            return league.strLeague.capitalized.contains(name.capitalized)
        })
    }
    
}
