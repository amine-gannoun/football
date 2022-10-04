//
//  LeagueDetailsVC.swift
//  Football
//
//  Created by Amine  on 01/10/2022.
//

import UIKit

class LeagueDetailsVC: UIViewController {
    
    //MARK: - UIOutlets
    @IBOutlet weak var ClubCV: UICollectionView!
    
    //MARK: - Variables
    var currentLeague : League?
    var teams : [Team] = []
    var presenter = LeagueDetailsPresenter()
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpOutlets()
        presenter.setDelegate(delegate: self)
        presenter.getAllTeams(strLeague: currentLeague?.strLeague ?? "")
        
    }
    
    func setUpOutlets(){
        
        title = currentLeague?.strLeague
        ClubCV.delegate = self
        ClubCV.dataSource = self
        let nibCell = UINib(nibName: "ClubCVCell", bundle: nil)
        ClubCV.register(nibCell, forCellWithReuseIdentifier: "ClubCVCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showClubDetailsSegue" {
            let selectedIndex : Int = sender as! Int
            let selectedTeam : Team = teams[selectedIndex]
            let teamdetails : TeamDetailsVC = segue.destination as! TeamDetailsVC
            teamdetails.currentTeam = selectedTeam
        }
    }
}

extension LeagueDetailsVC : LeagueDetailsPresenterDelegate {
    func didGetTeams(teams: [Team]) {
        self.teams = teams
        print("teeeams : \(teams)")
        DispatchQueue.main.async {
            self.ClubCV.reloadData()
        }
    }
}

//MARK: - CollectionView Data source & Delegate
extension LeagueDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ClubCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubCVCell", for: indexPath) as! ClubCVCell
        
        if let currentTeamImageURL : URL = URL(string: teams[indexPath.row].strTeamBadge ?? "") {
            cell.ClubImage.load(url: currentTeamImageURL)
        }else{
            cell.ClubImage.image = UIImage(named: "thumbnail")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.bounds.width - 50) / 2
        return CGSize(width: cellWidth, height: 200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showClubDetailsSegue", sender: indexPath.item)
    }
    
}
