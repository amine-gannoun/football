//
//  LeagueManager.swift
//  Football
//
//  Created by Amine  on 01/10/2022.
//

import Foundation

class LeagueManager {
    
    public static let shared = LeagueManager()
    
    // MARK: - get soccer leagues
    public func getSoccerLeagues(CompletionHandler: @escaping(([League]) -> ())) {

        guard let url : URL = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_leagues.php") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("error getting leagues")
                CompletionHandler([])
                return
            }
            print("data get all leagues : \(data)")
            
            do {
                let allLeagues = try JSONDecoder().decode(AllLeagues.self, from: data)
                
                // Get only soccer leagues
                let soccerLeagues : [League] = allLeagues.leagues.filter { league in
                     return league.strSport == "Soccer"
                }
                
                CompletionHandler(soccerLeagues)
                
            }catch{
                print("error decoding JSON")
                CompletionHandler([])
            }
            
        }
        task.resume()
    }
    
    //MARK: - get all teams of a league
    public func getLeagueTeams(strLeague: String, CompletionHandler: @escaping(([Team])->())){
        
        let strURL : String = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(strLeague)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let url : URL = URL(string: strURL) else {
            print("url not valiiiid")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                CompletionHandler([])
                return
            }
            do {
                let allTeams = try JSONDecoder().decode(Teams.self, from: data)
                CompletionHandler(allTeams.teams)
                
            }catch{
                print("error decoding JSON")
                CompletionHandler([])
            }
            
        }
        task.resume()
    }
    
}
