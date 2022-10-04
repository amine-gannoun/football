//
//  SearchLeagueVC.swift
//  Football
//
//  Created by Amine  on 30/09/2022.
//

import UIKit

class SearchLeagueVC: UIViewController {
    
    //MARK: - UI Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var propositionsTV: UITableView!
    
    //MARK: - Variables
    private let presenter = SearchLeaguePresenter()
    var suggestedLeagues : [League] = []
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUIOutlets()
        // prepare presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getAllSoccerLeagues()
        
    }
    
    func setUpUIOutlets(){
        
        let leagueNib = UINib(nibName: "LeagueTVCell", bundle: nil)
        propositionsTV.register(leagueNib, forCellReuseIdentifier: "LeagueTVCell")
        
        searchBar.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeagueClubsSegue" {
            let selectedLeagueIndex : Int = sender as! Int
            let selectedLeague : League = suggestedLeagues[selectedLeagueIndex]
            let leagueDetailsVC : LeagueDetailsVC = segue.destination as! LeagueDetailsVC
            leagueDetailsVC.currentLeague = selectedLeague
        }
    }
    
}

// MARK: - Presenter delegate
extension SearchLeagueVC : SearchLeaguePresenterDelegate {
    func didFilterLeagues(leagues: [League]) {
        suggestedLeagues = leagues
        DispatchQueue.main.async {
            self.propositionsTV.reloadData()
        }
    }
}

// MARK: - Search Bar delegate
extension SearchLeagueVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterLeagues(name: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Table View Delegate & Data Source
extension SearchLeagueVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LeagueTVCell = tableView.dequeueReusableCell(withIdentifier: "LeagueTVCell", for: indexPath) as! LeagueTVCell
        
        cell.leagueStrLabel.text = suggestedLeagues[indexPath.row].strLeague
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLeagueClubsSegue", sender: indexPath.row)
    }
}
